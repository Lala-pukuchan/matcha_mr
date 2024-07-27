const pool = require('../services/dbService');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { v4: uuidv4 } = require('uuid');
const transporter = require('../services/emailService');
const moment = require('moment');

const getUserInfo = async (req, res) => {
  let token;
  try {
    token = req.cookies.token;
    if (!token) {
      return res.json({ message: "No User" });F
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
};

// get users api
const getUser =  async (req, res) => {
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
};

const updateUser = async (req, res) => {
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
    const directory = "/app/uploads/";
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
    let queryString = "UPDATE user SET " + updateFields.join(", ") + " WHERE id = ?";
    values.push(userId);
    await conn.query(queryString, values);

    // update user tags
    await conn.query("DELETE FROM usertag WHERE user_id = ?", [userId]);
    const tagIds = req.body.tags;
    if (tagIds) {
      for (const tagId of tagIds) {
        await conn.query("INSERT INTO usertag(user_id, tag_id) VALUES (?, ?)", [userId, tagId]);
      }
    }

    // update jwt token
    const rows = await conn.query("SELECT * FROM user WHERE id = ?", [userId]);
    const token = await getJwt(rows[0], tagIds);
    res.cookie("token", token, { maxAge: 86400000 });

    // success message
    return res.status(200).json({ message: "success" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const enableUser = async (req, res) => {
  const token = req.query.token;
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    let conn;
    try {
      conn = await pool.getConnection();
      await conn.query("UPDATE user SET enabled = TRUE WHERE id = ?", [decoded.id]);
      res.send(
        `<!DOCTYPE html><html><body><p>Account has been successfully enabled. Please login from <br><a href="${process.env.FRONT_URL}/login">here</a>.</p></body></html>`
      );
    } catch (e) {
      console.log(e);
      return res.status(500).json({ message: "Internal server error" });
    } finally {
      if (conn) conn.end();
    }
  } catch (error) {
    return res.status(401).json({ message: "invalid token" });
  }
};

const reportUser = async (req, res) => {
  try {
    let conn;
    try {
      conn = await pool.getConnection();
      if (req.body.status) {
        await conn.query("UPDATE user SET fake_account = TRUE WHERE id = ?", [req.body.id]);
      } else {
        await conn.query("UPDATE user SET fake_account = FALSE WHERE id = ?", [req.body.id]);
      }
      res.json({ message: "success" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ message: "Internal server error" });
    } finally {
      if (conn) conn.end();
    }
  } catch (error) {
    return res.status(401).json({ message: "invalid token" });
  }
};

const insertViewed = async (req, res) => {
  console.log("req.body: ", req.body);
  let conn;
  try {
    conn = await pool.getConnection();
    await conn.query("INSERT INTO viewed (from_user_id, viewed_to_user_id, viewed_at) VALUES (?, ?, NOW())", [req.body.from, req.body.to]);
    console.log("result: ", result);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const getViewedUsers = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const viewedFromUsers = await conn.query("SELECT DISTINCT from_user_id FROM viewed WHERE viewed_to_user_id = ?", [req.body.userId]);
    if (viewedFromUsers.length > 0) {
      res.json(viewedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const insertLiked = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.from];
    const result = await conn.query("SELECT * FROM user WHERE id = ? AND profilePic != ''", values);
    if (result.length > 0) {
      const values = [req.body.from, req.body.to];
      await conn.query("INSERT INTO liked (from_user_id, liked_to_user_id, liked_at) VALUES (?, ?, NOW())", values);
      const reverseLiked = await conn.query("SELECT * FROM liked WHERE liked_to_user_id = ? AND from_user_id = ?", values);
      if (reverseLiked.length > 0) {
        await conn.query("INSERT INTO matched (matched_user_id_first, matched_user_id_second) VALUES (?, ?)", [req.body.to, req.body.from]);
        await conn.query("INSERT INTO rooms (user_id_first, user_id_second) VALUES (?, ?)", [req.body.from, req.body.to]);
      }
      const likeResult = await conn.query("SELECT * FROM liked WHERE from_user_id = ?", [req.body.from]);
      const matchResult = await conn.query("SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?", [req.body.from, req.body.from]);

      let matchRatio = 0;
      if (matchResult.length !== 0 && likeResult.length !== 0) {
        matchRatio = (matchResult.length / likeResult.length) * 100;
      }
      await conn.query("UPDATE user SET match_ratio = ? WHERE id = ?", [matchRatio, req.body.from]);
      return res.json({ message: "success" });
    } else {
      return res.status(400).json({ message: "User doesn't have a profile picture" });
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const insertBlocked = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.from, req.body.to];
    if (req.body.blocked) {
      await conn.query("INSERT INTO blocked (from_user_id, blocked_to_user_id, blocked_at) VALUES (?, ?, NOW())", values);
    } else {
      await conn.query("DELETE FROM blocked WHERE from_user_id = ? AND blocked_to_user_id = ?", values);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const getConnectedUsers = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const matchResult = await conn.query("SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?", [req.body.id, req.body.id]);
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
      if (userResult[0] && userResult[0].profilePic) {
        usersConnected.push(userResult[0]);
      }
    }
    return res.json(usersConnected);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const insertUnliked = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const values = [req.body.from, req.body.to];
    await conn.query("DELETE FROM liked WHERE from_user_id = ? AND liked_to_user_id = ?", values);
    values.push(values[0], values[1]);
    await conn.query("DELETE FROM matched WHERE (matched_user_id_first = ? AND matched_user_id_second = ?) OR (matched_user_id_second = ? AND matched_user_id_first = ?)", values);
    const likeResult = await conn.query("SELECT * FROM liked WHERE from_user_id = ?", [req.body.from]);
    const matchResult = await conn.query("SELECT * FROM matched WHERE matched_user_id_first = ? OR matched_user_id_second = ?", [req.body.from, req.body.from]);

    let matchRatio = 0;
    if (matchResult.length !== 0 && likeResult.length !== 0) {
      matchRatio = (matchResult.length / likeResult.length) * 100;
    }
    await conn.query("UPDATE user SET match_ratio = ? WHERE id = ?", [matchRatio, req.body.from]);
    return res.json({ message: "success" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const getLikedUsers = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const likedFromUsers = await conn.query("SELECT DISTINCT from_user_id FROM liked WHERE liked_to_user_id = ?", [req.body.userId]);
    if (likedFromUsers.length > 0) {
      res.json(likedFromUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const getLikedToUsers = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const likedToUsers = await conn.query("SELECT DISTINCT liked_to_user_id FROM liked WHERE from_user_id = ?", [req.body.userId]);
    if (likedToUsers.length > 0) {
      res.json(likedToUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

const getBlockedToUsers = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const blockedToUsers = await conn.query("SELECT DISTINCT blocked_to_user_id FROM blocked WHERE from_user_id = ?", [req.body.userId]);
    if (blockedToUsers.length > 0) {
      res.json(blockedToUsers);
    } else {
      res.json([]);
    }
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) conn.end();
  }
};

// get user api
const myAccount =  async (req, res) => {
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
};

const getTags = async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const tags = await conn.query("SELECT * FROM tag");
    res.json(tags);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    if (conn) return conn.end();
  }
};
const addNewTags = async (req, res) => {
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
}

module.exports = {
  getUserInfo,
  getUser,
  updateUser,
  enableUser,
  reportUser,
  insertViewed,
  getViewedUsers,
  insertLiked,
  insertBlocked,
  getConnectedUsers,
  insertUnliked,
  getLikedUsers,
  getLikedToUsers,
  getBlockedToUsers,
  myAccount,
  getTags,
  addNewTags,
};
