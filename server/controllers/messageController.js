const pool = require('../services/dbService');
const moment = require('moment');

const getMessages = async (req, res) => {
  const roomID = req.params.roomID;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT * FROM messages WHERE room_id = ? ORDER BY sent_at ASC';
    const messages = await conn.query(query, [roomID]);
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages from database: ', error);
    res.status(500).send('Internal Server Error');
  } finally {
    if (conn) conn.end();
  }
};

const saveMessage = async (room, message) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const roomQuery = 'SELECT user_id_first, user_id_second FROM rooms WHERE room_id = ?';
    const roomResult = await conn.query(roomQuery, [room]);

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
};

module.exports = {
  getMessages,
  saveMessage,
};
