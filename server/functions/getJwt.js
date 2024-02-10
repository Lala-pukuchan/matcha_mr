const jwt = require('jsonwebtoken');

// Define the async function
async function getJwt(row, tagIdsArray) {

  const payload = {
    id: row.id,
    email: row.email,
    username: row.username,
    lastname: row.lastname,
    firstname: row.firstname,
    gender: row.gender,
    preference: row.preference,
    biography: row.biography,
    profilePic: row.profilePic,
    pic1: row.pic1,
    pic2: row.pic2,
    pic3: row.pic3,
    pic4: row.pic4,
    pic5: row.pic5,
    tagIds: tagIdsArray,
  };

  const token = jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: "1d",
  });

  return token;
}

module.exports = getJwt;
