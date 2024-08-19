const pool = require('../services/dbService');

const getMatches = async (req, res) => {
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
};

const getCommonTags = async (req, res) => {
  let tagIds = req.body.tagIds;
  let query = `
  SELECT DISTINCT u.*
  FROM user u
  JOIN usertag ut ON u.id = ut.user_id
`;

  let whereConditions = [];
  let queryParams = [];
  if (tagIds && tagIds.length > 0) {
    if (!Array.isArray(tagIds)) {
      tagIds = [tagIds];
    }
    const placeholders = tagIds.map(() => "?").join(", ");
    whereConditions.push(`ut.tag_id IN (${placeholders})`);
    queryParams.push(...tagIds);
  }

  if (req.body.gender) {
    whereConditions.push("(u.preference = ? OR u.preference = 'no')");
    queryParams.push(req.body.gender);
  }
  if (req.body.preference && req.body.preference !== "no") {
    whereConditions.push("u.gender = ?");
    queryParams.push(req.body.preference);
  }

  if (whereConditions.length > 0) {
    query += " WHERE " + whereConditions.join(" AND ");
  }

  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query(query, queryParams);
    if (rows.length > 0) {
      for (let row of rows) {
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
    if (conn) conn.end();
  }
};

const getCloseUsers = async (req, res) => {
  const distanceThreshold = 10;
  let queryFields = [
    "(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance",
  ];
  let values = [req.body.latitude, req.body.longitude, req.body.latitude];

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

  let baseQuery = `SELECT *, ${queryFields[0]} FROM user`;
  if (queryFields.length > 1) {
    const whereClause = queryFields.slice(1).join(" AND ");
    baseQuery += " WHERE " + whereClause;
  }
  baseQuery += " HAVING distance < ? ORDER BY distance";
  values.push(distanceThreshold);

  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query(baseQuery, values);
    if (rows.length > 0) {
      for (let row of rows) {
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
    if (conn) conn.end();
  }
};

const getFrequentlyLikedBack = async (req, res) => {
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
    if (conn) conn.end();
  }
};

module.exports = {
  getMatches,
  getCommonTags,
  getCloseUsers,
  getFrequentlyLikedBack,
};
