const express = require('express');
const router = express.Router();
const matchController = require('../controllers/matchController');

router.get('/matches/:userId', matchController.getMatches);
router.post('/commonTags', matchController.getCommonTags);
router.post('/close', matchController.getCloseUsers);
router.post('/frequentlyLikedBack', matchController.getFrequentlyLikedBack);

module.exports = router;
