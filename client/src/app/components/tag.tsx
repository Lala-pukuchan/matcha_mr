import { useState, useEffect } from "react";

export default function Tag({ user }) {
  // set tags
  const [tags, setTags] = useState([]);

  // set created tags
  useEffect(() => {
    async function setCreatedTags() {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/tags`
        );
        if (response.status === 200) {
          const data = await response.json();
          setTags(data);
        } else {
          const data = await response.json();
          console.error(data);
        }
      } catch (e) {
        console.error(e);
      }
    }
    setCreatedTags();
  }, []);

  return (
    <div>
      <ul>
        {tags.map(
          (tag, index) =>
            user &&
            user.tagIds &&
            user.tagIds.includes(tag.id.toString()) && (
              <li key={`${tag.id}-${index}`}>
                <p>#{tag.name}</p>
              </li>
            )
        )}
      </ul>
    </div>
  );
}
