import { useState, useEffect } from "react";

export default function TagSelection({ user }) {
  // set tags
  const [tags, setTags] = useState([]);

  // set created tags
  useEffect(() => {
    async function setCreatedTags() {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/tags`
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
      <label htmlFor="fameRating" className="text-gray-400 font-bold">
        Tag
      </label>
      <br />
      <ul className="text-gray-400">
        {tags.map(
          (tag, index) =>
            user &&
            user.tagIds &&
            user.tagIds.includes(tag.id.toString()) && (
              <li key={`${tag.id}-${index}`}>
                <input
                  id={tag.id}
                  type="radio"
                  value={tag.id}
                  name="tagId"
                ></input>
                <label htmlFor={tag.id} className="pl-2">
                  #{tag.name}
                </label>
              </li>
            )
        )}
      </ul>
    </div>
  );
}
