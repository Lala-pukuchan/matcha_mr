const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const upload = require('../middlewares/uploadMiddleware');

router.post('/createUser', upload.none(), authController.createUser);
router.post('/login', upload.none(), authController.login);
router.post('/logout', authController.logout);
router.post('/resetpassword', upload.none(), authController.resetPassword);
router.post('/updatePassword', upload.none(), authController.updatePassword);

module.exports = router;
