const pool = require('../services/dbService');

const saveNotification = async (req, res) => {
  const { id, userId, type, message, fromUser, timestamp, checked } = req.body;
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

const deleteNotification = async (userId, fromUserId, type) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'DELETE FROM notifications WHERE user_id = ? AND from_user_id = ? AND type = ?';
    await conn.query(query, [userId, fromUserId, type]);
  } catch (error) {
    console.error('Error deleting notification:', error);
    throw error;
  } finally {
    if (conn) conn.end();
  }
};

const getNotifications = async (req, res) => {
  const userId = req.params.userId;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT * FROM notifications WHERE user_id = ?';
    const rows = await conn.query(query, [userId]);

    res.status(200).json(rows);
  } catch (error) {
    console.error('Error fetching notifications:', error);
    res.status(500).json({ message: 'Internal server error' });
  } finally {
    if (conn) conn.end();
  }
};

const markAsRead = async (req, res) => {
  const { notificationId } = req.params;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'UPDATE notifications SET checked = true WHERE id = ?';
    await conn.query(query, [notificationId]);
    res.status(200).json({ message: 'Notification marked as read' });
  } catch (error) {
    console.error('Error marking notification as read:', error);
    res.status(500).json({ message: 'Internal server error' });
  } finally {
    if (conn) conn.end();
  }
};

module.exports = {
  saveNotification,
  deleteNotification,
  getNotifications,
  markAsRead,
};