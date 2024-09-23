const express = require('express');
const router = express.Router();
const notificationController = require('../controllers/notificationController');

router.post('/save', notificationController.saveNotification);
router.get('/:userId', notificationController.getNotifications);
router.post('/markAsRead/:notificationId', notificationController.markAsRead);

module.exports = router;