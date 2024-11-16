const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const upload = require('../middlewares/uploadMiddleware');

router.get('/userinfo', userController.getUserInfo);
router.post('/getUser', userController.getUser);
router.post('/userById', userController.getUserById);
router.post('/getUserNameById', userController.getUserNameById);
router.post('/user/update', upload.fields([
  { name: 'profilePicture', maxCount: 1 },
  { name: 'picture1', maxCount: 1 },
  { name: 'picture2', maxCount: 1 },
  { name: 'picture3', maxCount: 1 },
  { name: 'picture4', maxCount: 1 },
  { name: 'picture5', maxCount: 1 },
]), userController.updateUser);
router.get('/enable', userController.enableUser);
router.post('/myAccount', userController.myAccount);
router.post('/user/report', userController.reportUser);
router.post('/viewed', userController.insertViewed);
router.post('/user/viewed', userController.getViewedUsers);
router.post('/liked', userController.insertLiked);
router.post('/blocked', userController.insertBlocked);
router.post('/users/connected', userController.getConnectedUsers);
router.post('/unliked', userController.insertUnliked);
router.post('/user/liked', userController.getLikedUsers);
router.post('/user/likedTo', userController.getLikedToUsers);
router.post('/user/blockedTo', userController.getBlockedToUsers);
router.get('/tags',userController.getTags);
router.post('/user/tags', userController.addNewTags);
router.post('/close', userController.closeAccount);
router.post('/connected', userController.insertConnected);
router.post('/checkMatched', userController.checkMatched);
router.post('/commonTags', userController.getCommonTags);
router.post('/frequentlyLikedBack', userController.getFrequentlyLikedBack);
router.post('/blockedTo', userController.getBlockedTo);
router.post('/blockedFrom', userController.getBlockedFrom);
router.post('/searchUser', upload.none(), userController.searchUser);
router.post('/onlineStatus', userController.onlineStatus);
router.post('/checkLikedStatus', userController.checkLikedStatus);
//close, connected, commonTags, frequestlyLikedBack, blockedto, 
module.exports = router;
