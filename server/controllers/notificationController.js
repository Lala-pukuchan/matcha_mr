const pool = require('../services/dbService');

const saveNotification = async (notification) => {
  const { id, userId, type, message, fromUser, timestamp, checked } = notification;
  console.log('notfication table SAVE id:::', notification.id);
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'INSERT INTO notifications (id, user_id, type, message, from_user_id, timestamp, checked) VALUES (?, ?, ?, ?, ?, ?, ?)';
    await conn.query(query, [id, userId, type, message, fromUser, timestamp, checked]);
  } catch (error) {
    console.error('Error saving notification:', error);
    throw error;
  } finally {
    if (conn) conn.release();
  }
};

const deleteNotification = async (userId, fromUserId, type) => {
  console.log(`Deleting notification for user ${userId} from ${fromUserId} with type ${type}`);
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'DELETE FROM notifications WHERE user_id = ? AND from_user_id = ? AND type = ?';
    await conn.query(query, [userId, fromUserId, type]);
  } catch (error) {
    console.error('Error deleting notification:', error);
    throw error;
  } finally {
    if (conn) conn.release();
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
    res.status(422).json({ message: 'Error processing request' });
  } finally {
    if (conn) conn.release();
  }
};

const markAsRead = async (req, res) => {
  const { notificationId } = req.params;
  console.log("notificationId:::", notificationId);
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'UPDATE notifications SET checked = true WHERE id = ?';
    await conn.query(query, [notificationId]);
    res.status(200).json({ message: 'Notification marked as read' });
  } catch (error) {
    console.error('Error marking notification as read:', error);
    res.status(422).json({ message: 'Error processing request' });
  } finally {
    if (conn) conn.release();
  }
};

const deleteAndSaveNotification = async (notification) => {
  const { userId, fromUser, type } = notification;
  console.log("nofitication.id:::", notification.id);
  let conn;
  const maxRetries = 3;
  let attempt = 0;

  while (attempt < maxRetries) {
    try {
      conn = await pool.getConnection();
      await conn.beginTransaction();

      const deleteQuery = 'DELETE FROM notifications WHERE user_id = ? AND from_user_id = ? AND type = ?';
      await conn.query(deleteQuery, [userId, fromUser, type]);

      const insertQuery = 'INSERT INTO notifications (id, user_id, type, message, from_user_id, timestamp, checked) VALUES (?, ?, ?, ?, ?, ?, ?)';
      await conn.query(insertQuery, [notification.id, notification.userId, notification.type, notification.message, notification.fromUser, notification.timestamp, notification.checked]);

      await conn.commit();
      return;
    } catch (error) {
      if (conn) await conn.rollback();
      if (error.code === 'ER_LOCK_DEADLOCK') {
        attempt++;
        console.error(`Deadlock detected, retrying transaction (${attempt}/${maxRetries})`);
        if (attempt >= maxRetries) {
          console.error('Max retries reached, throwing error');
          throw error;
        }
      } else {
        console.error('Error in deleteAndSaveNotification:', error);
        throw error;
      }
    } finally {
      if (conn) conn.release();
    }
  }
};

module.exports = {
  saveNotification,
  deleteNotification,
  getNotifications,
  markAsRead,
  deleteAndSaveNotification,
};