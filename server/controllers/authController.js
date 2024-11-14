const pool = require('../services/dbService');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const transporter = require('../services/emailService');
const getJwt = require("../functions/getJwt");
require('dotenv').config();


const createUser = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const query = "SELECT * FROM user WHERE username = ?";
    const values = [req.body.username];
    const result = await conn.query(query, values);
    if (result.length == 0) {
      const userId = uuidv4();
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(req.body.password, salt);
      const gender = req.body.gender;
      const preference = req.body.preference;
      const isRealUser = 1;
      //let profilePic;
      // if (gender === "male") {
      //   const randomNumber = Math.floor(Math.random() * 12) + 1;
      //   profilePic = `http://localhost:4000/uploads/${randomNumber}_boy.png`;
      // } else if (gender === "female") {
      //   const randomNumber = Math.floor(Math.random() * 12) + 1;
      //   profilePic = `http://localhost:4000/uploads/${randomNumber}_girl.png`;
      // } else {
      //   profilePic = "";
      // }
      const insertValues = [
        userId,
        req.body.email,
        req.body.username,
        req.body.lastname,
        req.body.firstname,
        hashedPassword,
        req.body.gender,
        preference,
        isRealUser,
      ];
      const result = await conn.query(
        "INSERT INTO user(id, email, username, lastname, firstname, password, gender, preference, isRealUser) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        insertValues
      );

      // create jwt
      const payload = {
        id: userId,
      };
      const token = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1d",
      });
      console.log("token:\n\n", token);
      
      // send email
      const mailSetting = {
        from: process.env.GMAIL_APP_USER,
        to: req.body.email,
        subject: "Enable Your Account",
        html: `
        <p>Hello ${req.body.username}</p><br><p>To enable your account, please click <a href="${process.env.NEXT_PUBLIC_API_URL}/api/users/enable?token=${token}">here</a>.</p>
        `,
      };
      transporter.sendMail(mailSetting, (error, info) => {
        if (error) {
          console.error("Error sending email: ", error);
          return res.status(422).json({ message: "Error sending email" });
        } else {
          console.log("Email sent: ", info.response);
        }
      });

      // return success message
      return res.json({
        message: "User created successfully",
        id: result.insertId.toString(),
      });
    } else {
      return res.status(400).json({ message: "Username already exists" });
    }
  } catch (e) {
    console.log(e);
    return res.status(422).json({ message: "Error creating user" });
  } finally {
    if (conn) return conn.end();
  }
};

const login = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const query = "SELECT * FROM user WHERE username = ?";
    const values = [req.body.username];
    const rows = await conn.query(query, values);
    if (rows.length == 0) {
      return res.status(401).json({ message: "Invalid username" });
    }
    if (!rows[0].enabled) {
      return res.status(401).json({ message: "User is not enabled" });
    }
    if (await bcrypt.compare(req.body.password, rows[0].password)) {
      const query = "SELECT tag_id FROM usertag WHERE user_id = ?";
      const userId = [rows[0].id];
      const result = await conn.query(query, userId);
      const tagIdsArray = result.map((tag) => tag.tag_id);
      await conn.query('UPDATE user SET status = ? WHERE id = ?', ['online', rows[0].id]);
      const token = await getJwt(rows[0], tagIdsArray);
      res.cookie("token", token, { maxAge: 86400000 });

      console.log(`User ${rows[0].id} logged in`);

      return res.json({ message: "Success", userId: rows[0].id }); // userIdを返す
    } else {
      return res.status(401).json({ message: "Invalid password" });
    }
  } catch (e) {
    console.log(e);
    return res.status(422).json({ message: "Error logging in" });
  } finally {
    if (conn) conn.end();
  }
};


const logout = async (req, res) => {
  let conn;
  try {
    const token = req.cookies.token;
    if (!token) {
      return res.status(401).json({ message: "Unauthorized" });
    }
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const userId = decoded.id;

    conn = await pool.getConnection();

    await conn.query('UPDATE user SET status = ? WHERE id = ?', ['offline', userId]);
    console.log(`User ${userId} logged out`);

    res.clearCookie("token", { path: "/" });
    res.send({ message: "success", userId });
  } catch (e) {
    console.log(e);
    res.status(422).json({ message: "Error logging out" });
  } finally {
    if (conn) conn.end();
  }
};



const resetPassword = async (req, res) => {
  let conn;
  try {
    const newPassword = generatePassword(10);
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    const values = [hashedPassword, req.body.username, req.body.email];
    conn = await pool.getConnection();
    await conn.query("UPDATE user SET password = ? WHERE username = ? AND email = ?", values);

    const mailSetting = {
      from: process.env.GMAIL_APP_USER,
      to: req.body.email,
      subject: "Reset Your Password",
      html: `<p>Your password is updated.<br>${newPassword}</p>`,
    };
    transporter.sendMail(mailSetting, (error, info) => {
      if (error) {
        console.error("Error sending email: ", error);
        return res.status(422).json({ message: "Error sending email" });
      } else {
        console.log("Email sent: ", info.response);
      }
    });
    return res.json({ message: "Please confirm new password via email" });
  } catch (e) {
    console.log(e);
    return res.status(422).json({ message: "Error resetting password" });
  } finally {
    if (conn) conn.end();
  }
};

const updatePassword = async (req, res) => {
  let conn;
  try {
    console.log(req.body);
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);
    const values = [hashedPassword, req.body.username];
    conn = await pool.getConnection();
    const result = await conn.query("UPDATE user SET password = ? WHERE username = ?", values);

    if (result.affectedRows > 0) {
      return res.status(200).json({ message: "Password is updated successfully." });
    } else {
      return res.status(404).json({ message: "User not found or password not updated." });
    }
  } catch (e) {
    console.log(e);
    return res.status(422).json({ message: "Error updating password" });
  } finally {
    if (conn) conn.end();
  }
};

const generatePassword = (length) => {
  const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+~`|}{[]:;?><,./-=";
  let password = "";
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * charset.length);
    password += charset[randomIndex];
  }
  return password;
};

module.exports = {
  createUser,
  login,
  logout,
  resetPassword,
  updatePassword,
};
