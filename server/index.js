const express = require('express');
const app = express();
const PORT = 4000;
const mariadb = require("mariadb");
const pool = mariadb.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  connectionLimit: 5,
});
app.get("/api/users/", async (req, res) => {
    let conn;
    try {
        conn = await pool.getConnection();
        const rows = await conn.query("SELECT * FROM user");
        return res.json(rows)
    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal server error" });
    } finally {
        if (conn) return conn.end();
    }
});

app.listen(PORT, () => {
    console.log(`Server listening at http://localhost:${PORT}`);
})
