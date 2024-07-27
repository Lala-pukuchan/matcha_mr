const moment = require('moment');
const onlineUsers = new Map();

function setupSocket(io, pool) {
  io.on('connection', (socket) => {
    console.log(`Client ${socket.id} connected`);

    socket.on('login', async (userId) => {
      console.log(`User ${userId} logged in with socket ${socket.id}`);
      if (!onlineUsers.has(userId)) {
        onlineUsers.set(userId, new Set());
      }
      onlineUsers.get(userId).add(socket.id);
      let conn;
      try {
        conn = await pool.getConnection();
        const query = 'UPDATE user SET last_active = ? WHERE id = ?';
        await conn.query(query, [new Date(), userId]);
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
        const query = 'UPDATE user SET last_active = ? WHERE id = ?';
        await conn.query(query, [new Date(), userId]);
        io.emit('user status', { userId, status: onlineUsers.has(userId) ? 'online' : 'offline' });
      } catch (error) {
        console.error('Error updating user status: ', error);
      } finally {
        if (conn) conn.end();
      }
    });

    socket.on('disconnect', async () => {
      console.log(`Client ${socket.id} disconnected`);
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
        let conn;
        try {
          conn = await pool.getConnection();
          const query = 'UPDATE user SET last_active = ? WHERE id = ?';
          await conn.query(query, [new Date(), userId]);
          io.emit('user status', { userId, status: onlineUsers.has(userId) ? 'online' : 'offline' });
        } catch (error) {
          console.error('Error updating user status: ', error);
        } finally {
          if (conn) conn.end();
        }
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
      console.log(`Received message in room ${room}: ${message.message}`);
      console.log("this is message: \n", message);
      io.to(room).emit('chat message', message);

      // メッセージをデータベースに保存
      let conn;
      try {
        conn = await pool.getConnection();

        // 送信相手を特定
        const roomQuery = 'SELECT user_id_first, user_id_second FROM rooms WHERE room_id = ?';
        const roomResult = await conn.query(roomQuery, [room]);
        console.log("roomResult", roomResult); // ここでログを追加して結果を確認

        if (!roomResult || roomResult.length === 0) {
          throw new Error('Room not found');
        }

        const { user_id_first, user_id_second } = roomResult[0];
        const toUserId = (message.from_user_id === user_id_first) ? user_id_second : user_id_first;

        const query = 'INSERT INTO messages (room_id, from_user_id, to_user_id, message, sent_at) VALUES (?, ?, ?, ?, ?)';
        const formattedDate = moment(message.sent_at).format('YYYY-MM-DD HH:mm:ss');
        const params = [room, message.from_user_id, toUserId, message.message, formattedDate];
        await conn.query(query, params);
      } catch (error) {
        console.error('Error saving message to database: ', error);
      } finally {
        if (conn) conn.end();
      }
    });

    socket.on('error', (error) => {
      console.error('Socket.io error: ', error);
    });
  });
}

module.exports = { setupSocket };
