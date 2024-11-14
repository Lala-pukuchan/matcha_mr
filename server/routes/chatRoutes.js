const express = require('express');
const router = express.Router();
const pool = require('../services/dbService'); // DB接続サービス

router.get('/matches/:userId', async (req, res) => {
  const userId = req.params.userId;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = `
      SELECT u.id, u.username, u.profilePic, r.room_id 
      FROM matched m 
      JOIN user u ON (m.matched_user_id_first = u.id OR m.matched_user_id_second = u.id)
      JOIN rooms r ON (r.user_id_first = ? AND r.user_id_second = u.id) OR (r.user_id_first = u.id AND r.user_id_second = ?)
      WHERE (m.matched_user_id_first = ? OR m.matched_user_id_second = ?) AND u.id != ?`;
    const rows = await conn.query(query, [userId, userId, userId, userId, userId]);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(422).send('Error processing request');
  } finally {
    if (conn) conn.end();
  }
});

router.get('/messages/:roomID', async (req, res) => {
  const roomID = req.params.roomID;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT * FROM messages WHERE room_id = ? ORDER BY sent_at ASC';
    const messages = await conn.query(query, [roomID]);
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages from database: ', error);
    res.status(422).send('Error processing request');
  } finally {
    if (conn) conn.end();
  }
});

module.exports = router;
