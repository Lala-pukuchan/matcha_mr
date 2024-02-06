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
app.post("/api/user", async (req, res) => {
  const { email, username, lastname, firstname, password } = req.body;

  // hash password
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  // create user
  let conn;
  try {
    conn = await pool.getConnection();
    const result = await conn.query(
      "INSERT INTO user(email, username, lastname, firstname, password) VALUES (?, ?, ?, ?, ?)",
      [email, username, lastname, firstname, hashedPassword]
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

// logout api
app.post("/api/logout", async (req, res) => {
  res.clearCookie("jwt");
  res.send({ message: "success" });
});

// start server
app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
