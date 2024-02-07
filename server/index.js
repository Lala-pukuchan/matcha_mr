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

// jwt for authentication
const jwt = require("jsonwebtoken");

// cookie parser
const cookieParser = require("cookie-parser");
app.use(cookieParser());

// form conversion
const multer = require("multer");
const upload = multer();

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
  // hash password
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(req.body.password, salt);

  // query parameter
  const values = [
    req.body.email,
    req.body.username,
    req.body.lastname,
    req.body.firstname,
    hashedPassword,
  ];

  // create user
  let conn;
  try {
    conn = await pool.getConnection();
    const result = await conn.query(
      "INSERT INTO user(email, username, lastname, firstname, password) VALUES (?, ?, ?, ?, ?)",
      values
    );
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

// login api
app.post("/api/login", upload.none(), async (req, res) => {
  // validate user
  let conn;
  try {
    conn = await pool.getConnection();
    query = "SELECT password FROM user WHERE username = ?";
    const values = [req.body.username];
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
