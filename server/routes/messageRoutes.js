const express = require('express');
const router = express.Router();
const messageController = require('../controllers/messageController');

router.get('/messages/:roomID', messageController.getMessages);

module.exports = router;
