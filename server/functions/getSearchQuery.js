async function getSearchQuery(data) {
  const user = JSON.parse(data.user);

  // baseQuery
  //  let baseQuery = `
  //    SELECT
  //    user.*,
  //    (6371 * acos(cos(radians(?)) * cos(radians(user.latitude)) * cos(radians(user.longitude) - radians(?)) + sin(radians(?)) * sin(radians(user.latitude)))) AS distance,
  //    (
  //        SELECT COUNT(ut2.tag_id)
  //        FROM usertag ut1
  //        JOIN usertag ut2 ON ut1.tag_id = ut2.tag_id AND ut2.user_id = user.id
  //        WHERE ut1.user_id = ? AND ut1.tag_id IN (?)
  //    ) AS common_tags_count
  //    FROM
  //    user
  //    `;
  let baseQuery = `
    SELECT 
    user.*
    FROM 
    user
    `;
  //  let values = [user.latitude, user.longitude, user.latitude];
  let values = [];
//  values.push(user.id);
//  values.push(user.tagIds);

  // where
  let whereConditions = [];
  if (user.gender) {
    whereConditions.push("(user.preference = ? OR user.preference = 'no')");
    values.push(user.gender);
  }
  if (user.preference && user.preference !== "no") {
    whereConditions.push("user.gender = ?");
    values.push(user.preference);
  }
  if (data.ageMin && data.ageMax) {
    whereConditions.push("user.age >= ? AND user.age <= ?");
    values.push(parseInt(data.ageMin), parseInt(data.ageMax));
  }
//  if (data.distanceMin && data.distanceMax) {
//    whereConditions.push("user.distance >= ? AND user.distance <= ?");
//    values.push(parseInt(data.distanceMin), parseInt(data.distanceMax));
//  }
  if (data.fameRatingMin && data.fameRatingMax) {
    whereConditions.push("user.match_ratio >= ? AND user.match_ratio <= ?");
    values.push(parseInt(data.fameRatingMin), parseInt(data.fameRatingMax));
  }
  if (data.tagId) {
    whereConditions.push("user.tagId = ?");
    values.push(parseInt(data.tagId));
  }
  if (whereConditions.length >= 0) {
    baseQuery += " WHERE " + whereConditions.join(" AND ");
  }

  // orderBy
  let orderByClause = "";
  switch (data.sort) {
    case "age":
      orderByClause = " ORDER BY user.age";
      break;
    case "distance":
      orderByClause = " ORDER BY distance";
      break;
    case "fameRating":
      orderByClause = " ORDER BY user.match_ratio";
      break;
    case "tag":
      orderByClause = " ORDER BY common_tags_count DESC";
      break;
    default:
      break;
  }
  baseQuery += orderByClause;

  console.log("baseQuery", baseQuery);
  console.log("values", values);

  return { baseQuery, values };
}

module.exports = getSearchQuery;
