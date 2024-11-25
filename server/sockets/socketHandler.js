const moment = require('moment');
const { v4: uuidv4 } = require('uuid');
const onlineUsers = new Map();
const socketIdMap = new Map();
const {saveNotification, deleteNotification, deleteAndSaveNotification} = require('../controllers/notificationController');
const pool = require('../services/dbService');

async function getUserNameById(userId) {
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT username FROM user WHERE id = ?';
    const rows = await conn.query(query, [userId]);
    if (rows.length > 0) {
      return rows[0].username;
    }
    return null;
  } catch (error) {
    console.error('Error fetching username: ', error);
    return null;
  } finally {
    if (conn) conn.end();
  }
}

function setupSocket(io, pool) {
  io.on('connection', (socket) => {
    console.log(`Client ${socket.id} connected`);

    socket.on('login', async (userId) => {
      console.log(`User ${userId} logged in with socket ${socket.id}`);
      socketIdMap.set(userId, socket.id);
      if (!onlineUsers.has(userId)) {
        onlineUsers.set(userId, new Set());
      }
      onlineUsers.get(userId).add(socket.id);

      let conn;
      try {
        conn = await pool.getConnection();
        const query = 'UPDATE user SET status = ?, last_active = ? WHERE id = ?';
        await conn.query(query, ['online', new Date(), userId]);

        io.emit('user status', { userId, status: 'online' });
      } catch (error) {
        console.error('Error updating user status: ', error);
      } finally {
        if (conn) conn.end();
      }
    });

    socket.on('logout', async (userId) => {
      console.log(`User ${userId} logged out with socket ${socket.id}`);
      if (onlineUsers.has(userId)) {
        onlineUsers.get(userId).delete(socket.id);
        if (onlineUsers.get(userId).size === 0) {
          onlineUsers.delete(userId);
        }
      }

      let conn;
      try {
        conn = await pool.getConnection();
        const query = 'UPDATE user SET status = ?, last_active = ? WHERE id = ?';
        await conn.query(query, ['offline', new Date(), userId]);

        io.emit('user status', { userId, status: 'offline' });
      } catch (error) {
        console.error('Error updating user status: ', error);
      } finally {
        if (conn) conn.end();
      }

      const onlineMatch = await getOnlineMatch(userId, pool);
      for (const match of onlineMatch) {
        const socketID = socketIdMap.get(match.id);
        io.to(socketID).emit('user disconnected');
      }
    });

    socket.on('disconnect', async (reason) => {
      console.log("disconnect!!! : socket.id: ", socket.id);
      console.log("reason is: ", reason);
      console.log(`Client ${socket.id} disconnected`);
      console.log("socket.connected: ", socket.connected);

      let userId;
      for (let [key, value] of onlineUsers) {
        if (value.has(socket.id)) {
          userId = key;
          value.delete(socket.id);
          if (value.size === 0) {
            onlineUsers.delete(key);
          }
          break;
        }
      }

      if (userId) {
        setTimeout(async () => {
          if (!onlineUsers.has(userId)) {
            let conn;
            try {
              conn = await pool.getConnection();
              const query = 'UPDATE user SET status = ?, last_active = ? WHERE id = ?';
              await conn.query(query, ['offline', new Date(), userId]);
              io.emit('user status', { userId, status: 'offline' });
            } catch (error) {
              console.error('Error updating user status: ', error);
            } finally {
              if (conn) conn.end();
            }
          }
        }, 5000);
      }
    });

    socket.on('joinRoom', (room) => {
      socket.join(room);
      console.log(`Socket ${socket.id} joined room ${room}`);
    });

    socket.on('leaveRoom', (room) => {
      socket.leave(room);
      console.log(`Socket ${socket.id} left room ${room}`);
    });

    socket.on('chat message', async (room, message) => {
      io.to(room).emit('chat message', message);

      let conn;
      try {
        conn = await pool.getConnection();
        const roomQuery = 'SELECT user_id_first, user_id_second FROM rooms WHERE room_id = ?';
        const [roomResult] = await conn.query(roomQuery, [room]);

        if (!roomResult || roomResult.length === 0) {
          throw new Error('Room not found');
        }

        const { user_id_first, user_id_second } = roomResult;
        const toUserId = (message.from_user_id === user_id_first) ? user_id_second : user_id_first;
        const fromUserId = (message.from_user_id === user_id_first) ? user_id_first : user_id_second;
        const query = 'INSERT INTO messages (room_id, from_user_id, to_user_id, message, sent_at) VALUES (?, ?, ?, ?, ?)';
        const formattedDate = moment(message.sent_at).format('YYYY-MM-DD HH:mm:ss');
        const params = [room, message.from_user_id, toUserId, message.message, formattedDate];
        await conn.query(query, params);

        const notificationId = uuidv4();
        if (socketIdMap.has(toUserId)) {
          io.to(socketIdMap.get(toUserId)).emit('message received', {
            id: notificationId,
            from_user_id: message.from_user_id,
          });
        }
        await deleteNotification(toUserId, fromUserId, 'message');

        const userName = await getUserNameById(fromUserId);
        const notification = {
          id: notificationId,
          userId: toUserId,
          type: 'message',
          message: `New message received from ${userName}`,
          fromUser: fromUserId,
          timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
          checked: false,
        };
        await saveNotification(notification);
      } catch (error) {
        console.error('Error handling message event: ', error);
      }
    });

    socket.on('like', async (data) => {
      const { fromUserId, toUserId } = data;
      const notificationId = uuidv4();
      if (socketIdMap.has(toUserId)) {
        io.to(socketIdMap.get(toUserId)).emit('like received', {
          id: notificationId,
          from_user_id: fromUserId,
        });
      }

      try {
        await deleteNotification(toUserId, fromUserId, 'unlike');

        const userName = await getUserNameById(fromUserId);
        const notification = {
          id: notificationId,
          userId: toUserId,
          type: 'like',
          message: `You received a like from ${userName}`,
          fromUser: fromUserId,
          timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
          checked: false,
        };
        await saveNotification(notification);
      } catch (error) {
        console.error('Error handling like event: ', error);
      }
    });

    socket.on('block', async (data) => {
      const { fromUserId, toUserId } = data;
      if (socketIdMap.has(toUserId)) {
        io.to(socketIdMap.get(toUserId)).emit('blocked', {
          from_user_id: fromUserId,
        });
      }
    });
  
    socket.on('unlike', async (data) => {
      const { fromUserId, toUserId } = data;
      const notificationId = uuidv4();
      if (socketIdMap.has(toUserId)) {
        io.to(socketIdMap.get(toUserId)).emit('unlike received', {
          id: notificationId,
          from_user_id: fromUserId,
        });
      }

      try {
        await deleteNotification(toUserId, fromUserId, 'like');

        const userName = await getUserNameById(fromUserId);
        const notification = {
          id: notificationId,
          userId: toUserId,
          type: 'unlike',
          message: `You received an unlike from ${userName}`,
          fromUser: fromUserId,
          timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
          checked: false,
        };
        await saveNotification(notification);
      } catch (error) {
        console.error('Error handling unlike event: ', error);
      }
    });
    socket.on('viewed', async (data) => {
      const { fromUserId, toUserId } = data;
      if (socketIdMap.has(toUserId)) {
        io.to(socketIdMap.get(toUserId)).emit('viewed received', {
          id: uuidv4(),
          from_user_id: fromUserId,
        });
      }
      try {
        const userName = await getUserNameById(fromUserId);
        const notification = {
          id: uuidv4(),
          userId: toUserId,
          type: 'viewed',
          message: `Your profile was viewed by ${userName}`,
          fromUser: fromUserId,
          timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
          checked: false,
        };
        await deleteAndSaveNotification(notification);
      } catch (error) {
        console.error('Error handling viewed event: ', error);
      }
    });

    socket.on('match', async (data) => {
      const { fromUserId, toUserId } = data;
      const notificationId = uuidv4();
      if (socketIdMap.has(toUserId)) {
        io.to(socketIdMap.get(toUserId)).emit('match received', {
          id: notificationId,
          from_user_id: fromUserId,
        });
      }

      try {
        const userName = await getUserNameById(fromUserId);
        const notification = {
          id: notificationId,
          userId: toUserId,
          type: 'match',
          message: `You have a new match with ${userName}`,
          fromUser: fromUserId,
          timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
          checked: false,
        };
        await deleteAndSaveNotification(notification);
      } catch (error) {
        console.error('Error handling match event: ', error);
      }
    });
    socket.on('error', (error) => {
      console.error('Socket.io error: ', error);
    });
  });
}

async function getOnlineMatch(id, pool) {
  if (id) {
    let conn;
    try {
      conn = await pool.getConnection();
      const query = `WITH a AS (SELECT matched.* FROM matched JOIN user ON (user.id=matched.matched_user_id_first OR
      user.id=matched.matched_user_id_second) WHERE user.id='${id}') SELECT user.id FROM a JOIN 
      user ON (user.id=a.matched_user_id_first OR user.id=a.matched_user_id_second) WHERE NOT user.id='${id}' and user.status ='online'`;
      const res = await conn.query(query);
      return res;
    } catch (error) {
      console.error('Error updating user status: ', error);
    } finally {
      if (conn) conn.end();
    }
  }
}
module.exports = { setupSocket, socketIdMap };
