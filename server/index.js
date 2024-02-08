// express server
const express = require("express");
const app = express();
const PORT = 4000;

// use cors
const cors = require("cors");
app.use(cors({ credentials: true, origin: "http://localhost" }));

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

// cookie parser
const cookieParser = require("cookie-parser");
app.use(cookieParser());

// form conversion
const multer = require("multer");
const upload = multer();

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
app.get("/api/user", async (req, res) => {
  // return userinfo inside jwt token
  let token;
  try {
    token = req.cookies.jwt;
  } catch (e) {
    return res.status(401).json({ message: "Unauthorized" });
  }
  const claims = jwt.verify(token, process.env.JWT_SECRET);
  if (!claims) {
    return res.status(401).json({ message: "Unauthorized" });
  }
  const { password, ...user } = claims;
  return res.json({ user });
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
      email: req.body.email,
      username: req.body.username,
      lastname: req.body.lastname,
      firstname: req.body.firstname,
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
        <p>To enable your account, please click <a href="http://localhost:4000/api/enable?token=${token}">here</a>.</p>
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
        '<!DOCTYPE html><html><body><p>Account has been successfully enabled.<br><a href="http://localhost">HOME</a></p></body></html>'
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
    query = "SELECT password FROM user WHERE id = ?";
    const values = [req.body.id];
    const rows = await conn.query(query, values);
    if (rows.length == 0) {
      return res.status(401).json({ message: "invalid username" });
    }
    if (await bcrypt.compare(req.body.password, rows[0].password)) {
      const payload = {
        id: rows[0].id,
        email: rows[0].email,
        username: rows[0].username,
        lastname: rows[0].lastname,
        firstname: rows[0].firstname,
      };
      const token = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1d",
      });
      res.cookie("token", token, {
        httpOnly: true,
        secure: true,
        sameSite: "strict",
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

// logout api
app.post("/api/logout", async (req, res) => {
  res.clearCookie("jwt");
  res.send({ message: "success" });
});

// start server
app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
