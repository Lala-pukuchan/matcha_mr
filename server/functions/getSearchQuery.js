async function getSearchQuery(data) {
  const user = JSON.parse(data.user);
  let baseQuery = `
    SELECT 
    user.*,
    COUNT(DISTINCT usertag.tag_id) AS common_tags_count,
    (6371 * acos(cos(radians(?)) * cos(radians(user.latitude)) * cos(radians(user.longitude) - radians(?)) + sin(radians(?)) * sin(radians(user.latitude)))) AS distance
    FROM 
    user
    JOIN usertag ON user.id = usertag.user_id
    `;
  let values = [
    parseFloat(user.latitude),
    parseFloat(user.longitude),
    parseFloat(user.latitude),
  ];

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
  if (data.fameRatingMin && data.fameRatingMax) {
    whereConditions.push("user.match_ratio >= ? AND user.match_ratio <= ?");
    values.push(parseInt(data.fameRatingMin), parseInt(data.fameRatingMax));
  }
  if (data.tagIds && data.tagIds.length > 0) {
    if (!Array.isArray(data.tagIds)) {
      whereConditions.push(`usertag.tag_id = ?`);
      values.push(data.tagIds);
    } else {
      let placeholders = data.tagIds.map(() => "?").join(",");
      whereConditions.push(`usertag.tag_id IN (${placeholders})`);
      values.push(...data.tagIds);
    }
  }
  if (whereConditions.length >= 0) {
    baseQuery += " WHERE " + whereConditions.join(" AND ");
  }

  // groupBy
  baseQuery += " GROUP BY user.id";

  // having
  let havingConditions = [];
  if (data.distanceMin && data.distanceMax) {
    havingConditions.push(`distance >= ? AND distance <= ?`);
    values.push(parseInt(data.distanceMin), parseInt(data.distanceMax));
  }
  if (havingConditions.length > 0) {
    baseQuery += " HAVING " + havingConditions.join(" AND ");
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
      orderByClause = " ORDER BY user.match_ratio DESC";
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
