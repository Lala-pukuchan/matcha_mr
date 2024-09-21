const pool = require('../services/dbService');

const saveNotification = async (req, res) => {
  const { id, userId, type, message, fromUser, timestamp, checked } = req.body;
  console.log("id::::::::::::::::::::::", id);
  console.log("req.body::::::::::::::::::::::", req.body);
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'INSERT INTO notifications (id, user_id, type, message, from_user_id, timestamp, checked) VALUES (?, ?, ?, ?, ?, ?, ?)';
    await conn.query(query, [id, userId, type, message, fromUser, timestamp, checked]);
    res.status(201).json({ message: 'Notification saved' });
  } catch (error) {
    console.error('Error saving notification:', error);
    res.status(500).json({ message: 'Internal server error' });
  } finally {
    if (conn) conn.end();
  }
};

const getNotifications = async (req, res) => {
  const { userId } = req.params;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT * FROM notifications WHERE user_id = ?';
    const [rows] = await conn.query(query, [userId]);
    res.status(200).json(rows);
  } catch (error) {
    console.error('Error fetching notifications:', error);
    res.status(500).json({ message: 'Internal server error' });
  } finally {
    if (conn) conn.end();
  }
};

module.exports = {
  saveNotification,
  getNotifications,
};