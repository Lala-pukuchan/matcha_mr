const getJwt = require("./functions/getJwt");
const getSearchQuery = require("./functions/getSearchQuery");

// express server
const express = require("express");
const app = express();
const PORT = 4000;

// access to uploaded img
const path = require("path");
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// use cors
const cors = require("cors");
app.use(cors({ credentials: true, origin: process.env.FRONT_URL }));

//socket
const moment = require('moment');
const http = require('http');
const { Server } = require("socket.io");
const server = http.createServer(app);
const corsOptions = {
    origin: ["http://localhost:1080", "http://localhost:3000"], // フロントエンドのURL
    credentials: true,
    methods: ["GET", "POST"],
    transport: ["websocket"],
    optionsSuccessStatus: 200 
  };
app.use(cors(corsOptions));
app.use(express.json());

app.get('/matches/:userId', async (req, res) => {
  const userId = req.params.userId;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = `
      SELECT u.id, u.username, u.profilePic, r.room_id 
      FROM matched m 
      JOIN user u ON (m.matched_user_id_first = u.id OR m.matched_user_id_second = u.id)
      JOIN rooms r ON (r.user_id_first = ? AND r.user_id_second = u.id) OR (r.user_id_first = u.id AND r.user_id_second = ?)
      WHERE (m.matched_user_id_first = ? OR m.matched_user_id_second = ?) AND u.id != ?`;
    const rows = await conn.query(query, [userId, userId, userId, userId, userId]);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  } finally {
    if (conn) conn.end();
  }
  console.log("userId:", userId);
});

app.get('/messages/:roomID', async (req, res) => {
  const roomID = req.params.roomID;
  let conn;
  try {
    conn = await pool.getConnection();
    const query = 'SELECT * FROM messages WHERE room_id = ? ORDER BY sent_at ASC';
    const messages = await conn.query(query, [roomID]);
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages from database: ', error);
    res.status(500).send('Internal Server Error');
  } finally {
    if (conn) conn.end();
  }
});
const io = new Server(server, {
  cors: corsOptions,
  transports: ['websocket', 'polling'],
});

// dbService
const pool = require('./services/dbService');

// WebSockethandler
const { setupSocket } = require('./sockets/socketHandler');
setupSocket(io, pool);

// ChatRoutes
const chatRoutes = require('./routes/chatRoutes');
app.use('/api', chatRoutes);

// use json
app.use(express.json());


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
const transporter = require('./services/emailService');

require('dotenv').config();
console.log("GMAIL_APP_PASSWORD", process.env.GMAIL_APP_PASSWORD);
console.log("GMAIL_APP_USER", process.env.GMAIL_APP_USER);

// get user api
app.get("/api/userinfo", async (req, res) => {
  // return userinfo inside jwt token
  let token;
  try {
    token = req.cookies.token;
    if (!token) {
      return res.json({ message: "No User" });
    }
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
app.post("/api/users/", async (req, res) => {
  // get gender and preference to show users
  let queryFields = [];
  let values = [];
  if (req.body.gender) {
    queryFields.push("(preference = ? OR preference = 'no')");
    values.push(req.body.gender);
  }
  if (req.body.preference) {
    if (req.body.preference === "no") {
      console.log("no preference");
    } else {
      queryFields.push("gender = ?");
      values.push(req.body.preference);
    }
  }

  // create query
  let baseQuery = "SELECT * FROM user";
  if (queryFields.length > 0) {
    const whereClause = queryFields.join(" AND ");
    baseQuery += " WHERE " + whereClause;
  }

  // get users
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query(baseQuery, values);
    if (rows.length > 0) {
      for (row of rows) {
        const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
        const tagValues = [row.id];
        const tagsResult = await conn.query(tagQuery, tagValues);
        const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
        row.tagIds = tagIdsArray;
      }
    }
    return res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// get users api
app.post("/api/users/close", async (req, res) => {
  // get users within 10km
  const distanceThreshold = 10;
  let queryFields = [
    "(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance",
  ];
  let values = [req.body.latitude, req.body.longitude, req.body.latitude];

  // Add gender and preference conditions
  if (req.body.gender) {
    queryFields.push("(preference = ? OR preference = 'no')");
    values.push(req.body.gender);
  }
  if (req.body.preference) {
    if (req.body.preference !== "no") {
      queryFields.push("gender = ?");
      values.push(req.body.preference);
    }
  }

  // create query
  let baseQuery = `SELECT *, ${queryFields[0]} FROM user`;
  if (queryFields.length > 1) {
    const whereClause = queryFields.slice(1).join(" AND ");
    baseQuery += " WHERE " + whereClause;
  }
  baseQuery += " HAVING distance < ? ORDER BY distance";
  values.push(distanceThreshold);

  // get users
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query(baseQuery, values);
    if (rows.length > 0) {
      for (row of rows) {
        const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
        const tagValues = [row.id];
        const tagsResult = await conn.query(tagQuery, tagValues);
        const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
        row.tagIds = tagIdsArray;
      }
    }
    return res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// get users api
app.post("/api/users/commonTags", async (req, res) => {
  // combine usertag and user tables
  const tagIds = req.body.tagIds;
  let query = `
  SELECT DISTINCT u.*
  FROM user u
  JOIN usertag ut ON u.id = ut.user_id
`;

  // create conditions and parameters
  let whereConditions = [];
  let queryParams = [];
  if (tagIds && tagIds.length > 0) {
    const placeholders = tagIds.map(() => "?").join(", ");
    whereConditions.push(`ut.tag_id IN (${placeholders})`);
    queryParams.push(...tagIds);
  }

  // Add gender and preference conditions
  if (req.body.gender) {
    whereConditions.push("(u.preference = ? OR u.preference = 'no')");
    queryParams.push(req.body.gender);
  }
  if (req.body.preference && req.body.preference !== "no") {
    whereConditions.push("u.gender = ?");
    queryParams.push(req.body.preference);
  }

  // Combine all conditions with "AND" and append to the query
  if (whereConditions.length > 0) {
    query += " WHERE " + whereConditions.join(" AND ");
  }

  // get users
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query(query, queryParams);
    if (rows.length > 0) {
      for (row of rows) {
        const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
        const tagValues = [row.id];
        const tagsResult = await conn.query(tagQuery, tagValues);
        const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
        row.tagIds = tagIdsArray;
      }
    }
    return res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// get users api
app.post("/api/users/frequentlyLikedBack", async (req, res) => {
  // get users who have high match ratio
  let conn;
  try {
    conn = await pool.getConnection();
    const query = "SELECT * FROM user WHERE match_ratio > 95 ORDER BY match_ratio DESC";
    const rows = await conn.query(query);
    res.json(rows);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// get user api
app.post("/api/user", async (req, res) => {
  const userId = req.body.userId;
  let conn;
  try {
    // get user
    conn = await pool.getConnection();
    let queryString = "SELECT * FROM user WHERE id = ?";
    let values = [req.body.userId];
    const userResult = await conn.query(queryString, values);
    if (userResult.length > 0) {
      // get tags
      const user = userResult[0];
      const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
      const tagsResult = await conn.query(tagQuery, values);
      const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
      user.tagIds = tagIdsArray;
      // get matched count
      const matchedQuery =
        "SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?";
      const matchedValues = [userId, userId];
      const matchedResult = await conn.query(matchedQuery, matchedValues);
      user.matched = matchedResult.length;
      // get liked count
      const likedQuery = "SELECT * FROM liked WHERE liked_to_user_id = ?";
      const likedValues = [userId];
      const likedResult = await conn.query(likedQuery, likedValues);
      user.liked = likedResult.length;
      // get viewed count
      const viewedQuery = "SELECT * FROM viewed WHERE viewed_to_user_id = ?";
      const viewedValues = [userId];
      const viewedResult = await conn.query(viewedQuery, viewedValues);
      user.viewed = viewedResult.length;
      res.json(user);
    } else {
      res.status(404).json({ message: "User not found" });
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});


// get user api
app.post("/api/myAccount", async (req, res) => {
  token = req.cookies.token;
  const claims = jwt.verify(token, process.env.JWT_SECRET);
  let conn;
  try {
    // get user
    conn = await pool.getConnection();
    let queryString = "SELECT * FROM user WHERE id = ?";
    let values = [claims.id];
    const userResult = await conn.query(queryString, values);
    console.log('userResult:', userResult);
    if (userResult.length > 0) {
      user = userResult[0];
      const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
      const tagsResult = await conn.query(tagQuery, values);
      const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
      user.tagIds = tagIdsArray;
      res.json(user);
    } else {
      res.status(404).json({ message: "User not found" });
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// create user api
app.post("/api/createUser", upload.none(), async (req, res) => {
  // create user
  let conn;
  try {
    conn = await pool.getConnection();
    const query = "SELECT * FROM user WHERE username = ?";
    const values = [req.body.username];
    const result = await conn.query(query, values);
    if (result.length == 0) {
      // generate unique userId
      const userId = uuidv4();
      // hash password
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(req.body.password, salt);
      // Set profilePic based on gender
      const gender = req.body.gender;
      const preference = req.body.preference;
      console.log("preferences:", preference);
      let profilePic;
      if (gender === "male") {
        const randomNumber = Math.floor(Math.random() * 12) + 1;
        profilePic = `http://localhost:4000/uploads/${randomNumber}_boy.png`;
      } else if (gender === "female") {
        const randomNumber = Math.floor(Math.random() * 12) + 1;
        profilePic = `http://localhost:4000/uploads/${randomNumber}_girl.png`;
      } else {
        profilePic = "";
      }
      // insert DB
      //conn = await pool.getConnection();
      const insertValues = [
        userId,
        req.body.email,
        req.body.username,
        req.body.lastname,
        req.body.firstname,
        hashedPassword,
        req.body.gender,
        preference,
        profilePic,
      ];
      const result = await conn.query(
        "INSERT INTO user(id, email, username, lastname, firstname, password, gender, preference, profilePic) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
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
        <p>Hello ${req.body.username}</p><br><p>To enable your account, please click <a href="http://localhost:${PORT}/api/enable?token=${token}">here</a>.</p>
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
    } else {
      return res.status(400).json({ message: "Username already exists" });
    }
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

    let updateFields = [];
    let values = [];
    if (req.body.lastname) {
      updateFields.push("lastname = ?");
      values.push(req.body.lastname);
    }
    if (req.body.firstname) {
      updateFields.push("firstname = ?");
      values.push(req.body.firstname);
    }
    if (req.body.email) {
      updateFields.push("email = ?");
      values.push(req.body.email);
    }
    if (req.body.gender) {
      updateFields.push("gender = ?");
      values.push(req.body.gender);
    }
    if (req.body.preference) {
      updateFields.push("preference = ?");
      values.push(req.body.preference);
    }
    if (req.body.biography) {
      updateFields.push("biography = ?");
      values.push(req.body.biography);
    }
    if (req.body.longitude) {
      updateFields.push("longitude = ?");
      values.push(req.body.longitude);
    }
    if (req.body.latitude) {
      updateFields.push("latitude = ?");
      values.push(req.body.latitude);
    }
    if (req.body.age) {
      updateFields.push("age = ?");
      const ageAsInt = parseInt(req.body.age, 10);
      if (!isNaN(ageAsInt)) {
        values.push(ageAsInt);
        console.error("ageAsInt:", ageAsInt);
      } else {
        console.error("Invalid age value:", req.body.age);
      }
    }

    // save uploaded images
    if (req.files) {
      if (req.files["profilePicture"]) {
        const { originalname, path } = req.files["profilePicture"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("profilePic = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
      if (req.files["picture1"]) {
        const { originalname, path } = req.files["picture1"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("pic1 = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
      if (req.files["picture2"]) {
        const { originalname, path } = req.files["picture2"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("pic2 = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
      if (req.files["picture3"]) {
        const { originalname, path } = req.files["picture3"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("pic3 = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
      if (req.files["picture4"]) {
        const { originalname, path } = req.files["picture4"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("pic4 = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
      if (req.files["picture5"]) {
        const { originalname, path } = req.files["picture5"][0];
        fs.renameSync(path, directory + originalname);
        updateFields.push("pic5 = ?");
        values.push(`http://localhost:${PORT}/uploads/` + originalname);
      }
    }

    // update user profile
    const userId = req.body.userId;
    let conn;
    try {
      conn = await pool.getConnection();
      let queryString =
        "UPDATE user SET " + updateFields.join(", ") + " WHERE id = ?";
      const userId = req.body.userId;
      values.push(userId);
      const result = await conn.query(queryString, values);

      // update user tags
      const user_id = [userId];
      await conn.query("DELETE FROM usertag WHERE user_id = ?", user_id);
      tagIds = req.body.tags;
      if (tagIds) {
        console.log("tagIds.length: ", tagIds.length);
        for (const tagId of tagIds) {
          const values = [userId, tagId];
          await conn.query(
            "INSERT INTO usertag(user_id, tag_id) VALUES (?, ?)",
            values
          );
        }
      }

      // update jwt token
      query = "SELECT * FROM user WHERE id = ?";
      const rows = await conn.query(query, user_id);
      const token = await getJwt(rows[0], tagIds);
      res.cookie("token", token, {
        maxAge: 86400000,
      });

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

// report user
app.post("/api/user/report", async (req, res) => {
  try {
    let conn, values;
    try {
      conn = await pool.getConnection();
      if (req.body.status) {
        const result = await conn.query(
          "UPDATE user SET fake_account = TRUE WHERE id = ?",
          [req.body.id]
        );
      } else {
        const result = await conn.query(
          "UPDATE user SET fake_account = FALSE WHERE id = ?",
          [req.body.id]
        );
      }
      res.json({ message: "success" });
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
      // get user tags
      const query = "SELECT tag_id FROM usertag WHERE user_id = ?";
      const userId = [rows[0].id];
      const result = await conn.query(query, userId);
      const tagIdsArray = result.map((tag) => tag.tag_id);
      // get jwt token
      const token = await getJwt(rows[0], tagIdsArray);
      res.cookie("token", token, {
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

// viewed api
app.post("/api/viewed", async (req, res) => {
  console.log("req.body: ", req.body);
  // insert viewed information
  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.from, req.body.to];
    const result = await conn.query(
      "INSERT INTO viewed (from_user_id, viewed_to_user_id, viewed_at) VALUES (?, ?, NOW())",
      values
    );
    console.log("result: ", result);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// viewed users api
app.post("/api/user/viewed", async (req, res) => {
  let conn;
  try {
    // get viwed from users
    conn = await pool.getConnection();
    let queryString =
      "SELECT DISTINCT from_user_id FROM viewed WHERE viewed_to_user_id = ?";
    let values = [req.body.userId];
    const viewedFromUsers = await conn.query(queryString, values);
    if (viewedFromUsers.length > 0) {
      res.json(viewedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// like api
app.post("/api/liked", async (req, res) => {
  let conn;
  try {
    // insert liked information
    conn = await pool.getConnection();
    const values = [req.body.from];
    const result = await conn.query(
      "SELECT * FROM user WHERE id = ? AND profilePic != ''",
      values
    );
    if (result.length > 0) {
      const values = [req.body.from, req.body.to];
      const result = await conn.query(
        "INSERT INTO liked (from_user_id, liked_to_user_id, liked_at) VALUES (?, ?, NOW())",
        values
      );
      // check if liked back
      const reverseLiked = await conn.query(
        "SELECT * FROM liked WHERE liked_to_user_id = ? AND from_user_id = ?",
        values
      );
      // match
      if (reverseLiked.length > 0) {
        const values2 = [req.body.to, req.body.from];
        const result2 = await conn.query(
          "INSERT INTO matched (matched_user_id_first, matched_user_id_second) VALUES (?, ?)",
          values2
        );
        //create chat room
        const roomValues = [req.body.from, req.body.to];
        const createRoom = await conn.query(
          "INSERT INTO rooms (user_id_first, user_id_second) VALUES (?, ?)",
          roomValues
        );
      }
      // matching ratio
      const likeQury = "SELECT * FROM liked WHERE from_user_id = ?";
      const likeVal = [req.body.from];
      const likeResult = await conn.query(likeQury, likeVal);
      const matchQuery =
        "SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?";
      const matchVal = [req.body.from, req.body.from];
      const matchResult = await conn.query(matchQuery, matchVal);

      // calculate match ratio
      let matchRatio = 0;
      if (matchResult.length !== 0 && likeResult.length !== 0) {
        matchRatio = (matchResult.length / likeResult.length) * 100;
      }
      const updateMatchRatio = "UPDATE user SET match_ratio = ? WHERE id = ?";
      const updateVal = [matchRatio, req.body.from];
      const updateResult = await conn.query(updateMatchRatio, updateVal);
      return res.json({ message: "success" });
    } else {
      return res.status(400).json({ message: "User doesn't have a profile picture" });
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// block api
app.post("/api/blocked", async (req, res) => {
  let conn;
  try {
    console.log("req.body: ", req.body);
    conn = await pool.getConnection();
    const values = [req.body.from, req.body.to];

    if (req.body.blocked) {
      // insert blocked information
      const result = await conn.query(
        "INSERT INTO blocked (from_user_id, blocked_to_user_id, blocked_at) VALUES (?, ?, NOW())",
        values
      );
    } else {
      // delete blocked information
      const result = await conn.query(
        "DELETE FROM blocked WHERE from_user_id = ? AND blocked_to_user_id = ?",
        values
      );
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// connected api
app.post("/api/users/connected", async (req, res) => {
  let conn;
  try {
    // connected users
    conn = await pool.getConnection();
    const matchQuery =
      "SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?";
    const matchVal = [req.body.id, req.body.id];
    const matchResult = await conn.query(matchQuery, matchVal);
    // get user info
    let usersConnected = [];
    const userQuery = "SELECT * FROM user WHERE id = ?";
    for (let match of matchResult) {
      let userVal;
      if (match.matched_user_id_first === req.body.id) {
        userVal = [match.matched_user_id_second];
      } else {
        userVal = [match.matched_user_id_first];
      }
      const userResult = await conn.query(userQuery, userVal);
      // if user has profile pic
      if (userResult[0] && userResult[0].profilePic) {
        usersConnected.push(userResult[0]);
      }
    }
    return res.json(usersConnected);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// unlike api
app.post("/api/unliked", async (req, res) => {
  let conn;
  console.log(req.body);
  try {
    // delete liked
    conn = await pool.getConnection();
    const values = [req.body.from, req.body.to];
    result = await conn.query(
      "DELETE FROM liked WHERE from_user_id = ? AND liked_to_user_id = ?",
      values
    );
    // delete matched
    values.push(values[0], values[1]);
    const result2 = await conn.query(
      "DELETE FROM matched WHERE (matched_user_id_first = ? AND matched_user_id_second = ?) OR (matched_user_id_second = ? AND matched_user_id_first = ?)",
      values
    );
    // matching ratio
    const likeQury = "SELECT * FROM liked WHERE from_user_id = ?";
    const likeVal = [req.body.from];
    const likeResult = await conn.query(likeQury, likeVal);
    const matchQuery =
      "SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?";
    const matchVal = [req.body.from, req.body.from];
    const matchResult = await conn.query(matchQuery, matchVal);

    // calculate match ratio
    let matchRatio = 0;
    if (matchResult.length !== 0 && likeResult.length !== 0) {
      matchRatio = (matchResult.length / likeResult.length) * 100;
    }
    const updateMatchRatio = "UPDATE user SET match_ratio = ? WHERE id = ?";
    const updateVal = [matchRatio, req.body.from];
    const updateResult = await conn.query(updateMatchRatio, updateVal);
    return res.json({ message: "success" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// liked users api
app.post("/api/user/liked", async (req, res) => {
  let conn;
  try {
    // get viwed from users
    conn = await pool.getConnection();
    let queryString =
      "SELECT DISTINCT from_user_id FROM liked WHERE liked_to_user_id = ?";
    let values = [req.body.userId];
    const likedFromUsers = await conn.query(queryString, values);
    if (likedFromUsers.length > 0) {
      res.json(likedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// liked users api
app.post("/api/user/likedTo", async (req, res) => {
  let conn;
  try {
    // get viwed from users
    conn = await pool.getConnection();
    let queryString =
      "SELECT DISTINCT liked_to_user_id FROM liked WHERE from_user_id = ?";
    let values = [req.body.userId];
    const likedFromUsers = await conn.query(queryString, values);
    if (likedFromUsers.length > 0) {
      res.json(likedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});

// blocked users api
app.post("/api/user/blockedTo", async (req, res) => {
  let conn;
  try {
    // get viwed from users
    conn = await pool.getConnection();
    let queryString =
      "SELECT DISTINCT blocked_to_user_id FROM blocked WHERE from_user_id = ?";
    let values = [req.body.userId];
    const blockedFromUsers = await conn.query(queryString, values);
    if (blockedFromUsers.length > 0) {
      res.json(blockedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
});



function generatePassword(length) {
  const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+~`|}{[]:;?><,./-=";
  let password = "";
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * charset.length);
    password += charset[randomIndex];
  }
  return password;
}

// resetpassword api
app.post("/api/resetpassword", upload.none(), async (req, res) => {
  let conn;
  try {
    // generate new password
    const newPassword = generatePassword(10);
    // hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    const values = [hashedPassword, req.body.username, req.body.email];
    conn = await pool.getConnection();
    const result = await conn.query(
      "UPDATE user SET password = ? WHERE username = ? AND email = ?",
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
  });
  res.send({ message: "success" });
});

// get tags
app.get("/api/tags", async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query("SELECT * FROM tag");
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
  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.name];
    const existing = await conn.query(
      "SELECT * FROM tag WHERE name = (?)",
      values
    );
    if (existing.length > 0) {
      return res.status(200).json({ message: "Tag is existing" });
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

// login api
app.post("/api/searchUser", upload.none(), async (req, res) => {
  // validate user
  let conn;
  try {
    conn = await pool.getConnection();
    console.log("req.body: ", req.body);
    const { baseQuery, values } = await getSearchQuery(req.body);
    console.log("baseQuery: ", baseQuery);
    console.log("values: ", values);
    const rows = await conn.query(baseQuery, values);
    console.log("rows: ", rows);
    // add tags
    if (rows.length > 0) {
      for (row of rows) {
        const tagQuery = "SELECT tag_id FROM usertag WHERE user_id = ?";
        const tagValues = [row.id];
        const tagsResult = await conn.query(tagQuery, tagValues);
        const tagIdsArray = tagsResult.map((tag) => tag.tag_id);
        row.tagIds = tagIdsArray;
      }
    }
    // Convert BigInt to String to create json
    const serializedRows = rows.map((row) => ({
      ...row,
      common_tags_count: row.common_tags_count.toString(),
    }));
    return res.json(serializedRows);
  } catch (e) {
    console.log(e);
  } finally {
    if (conn) return conn.end();
  }
});

// start server
server.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
