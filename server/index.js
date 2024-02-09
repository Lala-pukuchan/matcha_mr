// express server
const express = require("express");
const app = express();
const PORT = 4000;

// use cors
const cors = require("cors");
app.use(cors({ credentials: true, origin: process.env.FRONT_URL }));

// use json
app.use(express.json());

// db connection
const mariadb = require("mariadb");
const pool = mariadb.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  connectionLimit: 5,
});

// bcrypt for password hashing
const bcrypt = require("bcrypt");

// create unique userId
const { v4: uuidv4 } = require("uuid");

// jwt for authentication
const jwt = require("jsonwebtoken");

// password generator
const crypto = require("crypto");

// cookie parser
const cookieParser = require("cookie-parser");
app.use(cookieParser());

// form conversion
const multer = require("multer");
const upload = multer({ dest: "uploads/" });
const directory = "/app/uploads/";
const fs = require("fs");

// mail
const nodemailer = require("nodemailer");
const transporter = nodemailer.createTransport({
  service: "Gmail",
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: process.env.GMAIL_APP_USER,
    pass: process.env.GMAIL_APP_PASSWORD,
  },
});

// get user api
app.get("/api/userinfo", async (req, res) => {
  // return userinfo inside jwt token
  let token;
  try {
    token = req.cookies.token;
    const claims = jwt.verify(token, process.env.JWT_SECRET);
    if (!claims) {
      return res.status(401).json({ message: "Unauthorized" });
    }
    const { password, ...user } = claims;
    return res.json({ user });
  } catch (e) {
    return res.status(401).json({ message: "Unauthorized" });
  }
});

// get users api
app.get("/api/users/", async (req, res) => {
  // get users
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query("SELECT * FROM user");
    return res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// create user api
app.post("/api/user", upload.none(), async (req, res) => {
  // create user
  let conn;
  try {
    // generate unique userId
    const userId = uuidv4();
    // hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    // insert DB
    conn = await pool.getConnection();
    const values = [
      userId,
      req.body.email,
      req.body.username,
      req.body.lastname,
      req.body.firstname,
      hashedPassword,
    ];
    const result = await conn.query(
      "INSERT INTO user(id, email, username, lastname, firstname, password) VALUES (?, ?, ?, ?, ?, ?)",
      values
    );

    // create jwt
    const payload = {
      id: userId,
    };
    const token = jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });

    // send email
    const mailSetting = {
      from: process.env.GMAIL_APP_USER,
      to: req.body.email,
      subject: "Enable Your Account",
      html: `
        <p>To enable your account, please click <a href="http://localhost:${PORT}/api/enable?token=${token}">here</a>.</p>
      `,
    };
    transporter.sendMail(mailSetting, (error, info) => {
      if (error) {
        console.error("Error sending email: ", error);
        return res.status(500).json({ message: "Internal server error" });
      } else {
        console.log("Email sent: ", info.response);
      }
    });

    // return success message
    return res.json({
      message: "User created successfully",
      id: result.insertId.toString(),
    });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// update userinfo
app.post(
  "/api/user/update",
  upload.fields([
    { name: "profilePicture", maxCount: 1 },
    { name: "picture1", maxCount: 1 },
    { name: "picture2", maxCount: 1 },
    { name: "picture3", maxCount: 1 },
    { name: "picture4", maxCount: 1 },
    { name: "picture5", maxCount: 1 },
  ]),
  async (req, res) => {
    console.log("req.body:", req.body);

    // save files
    let profilePicture = "";
    let picture1 = "";
    let picture2 = "";
    let picture3 = "";
    let picture4 = "";
    let picture5 = "";
    if (req.files) {
      if (req.files["profilePicture"]) {
        const { originalname, path } = req.files["profilePicture"][0];
        fs.renameSync(path, directory + originalname);
        profilePicture = originalname;
      }
      if (req.files["picture1"]) {
        const { originalname, path } = req.files["picture1"][0];
        fs.renameSync(path, directory + originalname);
        picture1 = originalname;
      }
      if (req.files["picture2"]) {
        const { originalname, path } = req.files["picture2"][0];
        fs.renameSync(path, directory + originalname);
        picture2 = originalname;
      }
      if (req.files["picture3"]) {
        const { originalname, path } = req.files["picture3"][0];
        fs.renameSync(path, directory + originalname);
        picture3 = originalname;
      }
      if (req.files["picture4"]) {
        const { originalname, path } = req.files["picture4"][0];
        fs.renameSync(path, directory + originalname);
        picture4 = originalname;
      }
      if (req.files["picture5"]) {
        const { originalname, path } = req.files["picture5"][0];
        fs.renameSync(path, directory + originalname);
        picture5 = originalname;
      }
    }

    // update user profile
    const userId = req.body.userId;
    let conn;
    try {
      conn = await pool.getConnection();
      const values = [
        req.body.gender,
        req.body.preference,
        req.body.biography,
        profilePicture,
        picture1,
        picture2,
        picture3,
        picture4,
        picture5,
        userId,
      ];
      const result = await conn.query(
        "UPDATE user SET gender = ?, preference = ?, biography = ?, profilePic = ?, pic1 = ?, pic2 = ?, pic3 = ?, pic4 = ?, pic5 = ? WHERE id = ?",
        values
      );

      // update user tags
      let tagIds;
      if (req.body.tags) {
        tagIds = [...req.body.tags];
        for (const tagId of tagIds) {
          const values = [userId, tagId];
          await conn.query(
            "INSERT INTO usertag(user_id, tag_id) VALUES (?, ?)",
            values
          );
        }
      }

      // success message
      return res.status(200).json({ message: "success" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ message: "Internal server error" });
    } finally {
      if (conn) return conn.end();
    }
  }
);

// enable user
app.get("/api/enable", async (req, res) => {
  const token = req.query.token;
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    let conn;
    try {
      conn = await pool.getConnection();
      const userId = [decoded.id];
      const result = await conn.query(
        "UPDATE user SET enabled = TRUE WHERE id = ?",
        [userId]
      );
      res.send(
        `<!DOCTYPE html><html><body><p>Account has been successfully enabled.Please login from <br><a href="${process.env.FRONT_URL}/login">here</a></p></body></html>`
      );
    } catch (e) {
      console.log(e);
      return res.status(500).json({ message: "Internal server error" });
    } finally {
      if (conn) return conn.end();
    }
  } catch (error) {
    return res.status(401).json({ message: "invalid token" });
  }
});

// login api
app.post("/api/login", upload.none(), async (req, res) => {
  // validate user
  let conn;
  try {
    conn = await pool.getConnection();
    query = "SELECT * FROM user WHERE username = ?";
    const values = [req.body.username];
    const rows = await conn.query(query, values);
    if (rows.length == 0) {
      return res.status(401).json({ message: "invalid username" });
    }
    if (!rows[0].enabled) {
      return res.status(401).json({ message: "user is not enabled" });
    }
    if (await bcrypt.compare(req.body.password, rows[0].password)) {
      const payload = {
        id: rows[0].id,
        email: rows[0].email,
        username: rows[0].username,
        lastname: rows[0].lastname,
        firstname: rows[0].firstname,
        gender: rows[0].gender,
        preference: rows[0].preference,
        biography: rows[0].biography,
        profilePic: rows[0].profilePic,
        pic1: rows[0].pic1,
        pic2: rows[0].pic2,
        pic3: rows[0].pic3,
        pic4: rows[0].pic4,
        pic5: rows[0].pic5,
      };
      const token = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1d",
      });
      res.cookie("token", token, {
        httpOnly: true,
        maxAge: 86400000,
      });
      return res.json({ message: "success" });
    } else {
      return res.status(401).json({ message: "invalid password" });
    }
  } catch (e) {
    console.log(e);
  } finally {
    if (conn) return conn.end();
  }
});

// resetpassword api
app.post("/api/resetpassword", upload.none(), async (req, res) => {
  let conn;
  try {
    // generate new password
    const buffer = crypto.randomBytes(10);
    const newPassword = buffer.toString("hex").slice(0, 10);
    // hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    const values = [hashedPassword, req.body.email];
    conn = await pool.getConnection();
    const result = await conn.query(
      "UPDATE user SET password = ? WHERE email = ?",
      values
    );

    // send email
    const mailSetting = {
      from: process.env.GMAIL_APP_USER,
      to: req.body.email,
      subject: "Reset Your Password",
      html: `
        <p>Your password is updated.<br>${newPassword}</p>
      `,
    };
    transporter.sendMail(mailSetting, (error, info) => {
      if (error) {
        console.error("Error sending email: ", error);
        return res.status(500).json({ message: "Internal server error" });
      } else {
        console.log("Email sent: ", info.response);
      }
    });
    return res.json({ message: "Please confirm new password via email" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// logout api
app.post("/api/logout", async (req, res) => {
  console.log("token delete");
  res.clearCookie("token", {
    path: "/",
    httpOnly: true,
  });
  res.send({ message: "success" });
});

// get tags
app.get("/api/tags", async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query("SELECT * FROM tag");
    console.log("tags:", rows);
    return res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// add new tag
app.post("/api/tag", async (req, res) => {
  console.log("tag: ", req.body);

  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.name];
    const existing = await conn.query(
      "SELECT * FROM tag WHERE name = (?)",
      values
    );
    if (existing.length > 0) {
      return res.status(401).json({ message: "Tag is existing" });
    } else {
      const rows = await conn.query("INSERT INTO tag(name) VALUES (?)", values);
      const result = await conn.query(
        "SELECT * FROM tag WHERE name = (?)",
        values
      );
      return res.json(result[0]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// start server
app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
