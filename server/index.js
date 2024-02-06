// express server
const express = require("express");
const app = express();
const PORT = 4000;

// use cors
const cors = require("cors");
app.use(cors());

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

// users api
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

// login api
app.post("/api/login", async (req, res) => {
  const { username, password } = req.body;

  // get user
  let conn;
  try {
    conn = await pool.getConnection();
    const result = await conn.query("SELECT * FROM user WHERE username = ?", [
      username,
    ]);
    if (result.length === 0) {
      return res.status(404).json({ message: "No user is found." });
    } else {
      const user = result[0];
      if (!(await bcrypt.compare(password, user.password))) {
        return res.status(400).json({ message: "Password is invalid." });
      } else {
        // put jwt token in cookie
        const token = jwt.sign(user.id, process.env.JWT_SECRET);
        res.cookie("jwt", token, {
          httpOnly: true,
          maxAge: 24 * 60 * 60 * 1000,
        });
        return res.json({ message: "success" });
      }
    }
  } catch (e) {
    console.log(e);
  } finally {
    if (conn) return conn.end();
  }
});

// start server
app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
