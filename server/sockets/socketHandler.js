const moment = require('moment');
const onlineUsers = new Map();
const socketIdMap = new Map();

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

        const query = 'INSERT INTO messages (room_id, from_user_id, to_user_id, message, sent_at) VALUES (?, ?, ?, ?, ?)';
        const formattedDate = moment(message.sent_at).format('YYYY-MM-DD HH:mm:ss');
        const params = [room, message.from_user_id, toUserId, message.message, formattedDate];
        await conn.query(query, params);

        if (socketIdMap.has(toUserId)) {
          io.to(socketIdMap.get(toUserId)).emit('message received', { from_user_id: message.from_user_id });
        }
      } catch (error) {
        console.error('Error saving message to database: ', error);
      } finally {
        if (conn) conn.end();
      }
    });
    socket.on('like', async (data) => {
      const { fromUserId, toUserId } = data;
      io.to(toUserId).emit('like received', {
        id: new Date().getTime().toString(),
        from_user_id: fromUserId,
      });
    });
  
    socket.on('unlike', async (data) => {
      const { fromUserId, toUserId } = data;
      io.to(toUserId).emit('unlike received', {
        id: new Date().getTime().toString(),
        from_user_id: fromUserId,
      });
    });
  
    socket.on('match', async (data) => {
      const { fromUserId, toUserId } = data;
      io.to(toUserId).emit('match received', {
        id: new Date().getTime().toString(),
        from_user_id: fromUserId,
      });
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
module.exports = { setupSocket };
