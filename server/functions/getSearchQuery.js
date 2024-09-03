async function getSearchQuery(data) {
  console.log("data", data);

  let user;
  try {
    user = JSON.parse(data.user);
  } catch (error) {
    console.error("Invalid JSON format in data.user:", data.user);
    throw new Error("Invalid user data");
  }

  let baseQuery = `
    SELECT 
      user.*,
      COUNT(DISTINCT usertag.tag_id) AS common_tags_count,
      (6371 * acos(
        cos(radians(?)) * cos(radians(user.latitude)) * 
        cos(radians(user.longitude) - radians(?)) + 
        sin(radians(?)) * sin(radians(user.latitude))
      )) AS distance
    FROM 
      user
    LEFT JOIN 
      usertag ON user.id = usertag.user_id
  `;
  
  let values = [
    parseFloat(user.latitude),
    parseFloat(user.longitude),
    parseFloat(user.latitude),
  ];

  let whereConditions = [];
  
  // Gender and Preference filter
  if (user.gender && user.preference) {
    whereConditions.push(`
      (user.gender = ? AND user.preference = ?)
    `);
    values.push(user.preference, user.gender);
  }

  // Age range filter
  if (data.min_age && data.max_age) {
    whereConditions.push("user.age BETWEEN ? AND ?");
    values.push(parseInt(data.min_age), parseInt(data.max_age));
  }

  // Fame rating filter
  if (data.min_fame_rating && data.max_fame_rating) {
    whereConditions.push("user.match_ratio BETWEEN ? AND ?");
    values.push(parseInt(data.min_fame_rating), parseInt(data.max_fame_rating));
  }

  // Tag filter
  if (data.tags && data.tags.length > 0) {
    let placeholders = data.tags.map(() => "?").join(",");
    whereConditions.push(`
      user.id IN (
        SELECT user_id 
        FROM usertag 
        WHERE tag_id IN (${placeholders}) 
        GROUP BY user_id 
        HAVING COUNT(DISTINCT tag_id) = ?
      )
    `);
    values.push(...data.tags, data.tags.length);
  }

  // Combine where conditions
  if (whereConditions.length > 0) {
    baseQuery += " WHERE " + whereConditions.join(" AND ");
  }
  
  // Group by user ID
  baseQuery += " GROUP BY user.id";
  
  // Distance filter in HAVING clause
  let havingConditions = [];
  if (data.min_distance != null && data.max_distance != null) {
    havingConditions.push("distance BETWEEN ? AND ?");
    values.push(parseInt(data.min_distance), parseInt(data.max_distance));
  }

  // Add min_common_tag_count filter
  if (data.min_common_tag_count != null) {
    havingConditions.push("common_tags_count >= ?");
    values.push(parseInt(data.min_common_tag_count));
  }

  if (havingConditions.length > 0) {
    baseQuery += " HAVING " + havingConditions.join(" AND ");
  }

  // Order by clause
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
      orderByClause = " ORDER BY distance ASC"; // Default ordering by distance
      break;
  }
  baseQuery += orderByClause;

  console.log("Final baseQuery", baseQuery);
  console.log("Final values", values);
  
  return { baseQuery, values };
}

module.exports = getSearchQuery;
