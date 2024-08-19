const { body, validationResult } = require('express-validator');
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

const saveMessage = [
  body('message').trim().isLength({ min: 1 }).withMessage('Message cannot be empty.'),
  body('from_user_id').isUUID().withMessage('Invalid user ID format.'),
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    let conn;
    try {
      const { room, message } = req.body;

      conn = await pool.getConnection();
      const roomQuery = 'SELECT user_id_first, user_id_second FROM rooms WHERE room_id = ?';
      const [roomResult] = await conn.query(roomQuery, [room]);

      if (!roomResult || roomResult.length === 0) {
        return res.status(404).json({ error: 'Room not found' });
      }

      const { user_id_first, user_id_second } = roomResult[0];
      const toUserId = (message.from_user_id === user_id_first) ? user_id_second : user_id_first;

      const query = 'INSERT INTO messages (room_id, from_user_id, to_user_id, message, sent_at) VALUES (?, ?, ?, ?, ?)';
      const formattedDate = moment(message.sent_at).format('YYYY-MM-DD HH:mm:ss');
      const params = [room, message.from_user_id, toUserId, message.message, formattedDate];
      await conn.query(query, params);
      req.io.to(socketIdMap.get(toUserId)).emit('message received', { from_user_id: message.from_user_id });

      res.status(200).json({ success: true });
    } catch (error) {
      console.error('Error saving message to database: ', error);
      res.status(500).json({ error: 'Internal Server Error' });
    } finally {
      if (conn) conn.end();
    }
  }
];

module.exports = {
  getMessages,
  saveMessage,
};