import { useState, useEffect } from "react";

export default function Tag({ user }) {
  const [tags, setTags] = useState([]);

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
    <div className="flex flex-wrap gap-2 mt-2">
      {tags.map(
        (tag, index) =>
          user &&
          user.tagIds &&
          user.tagIds.includes(tag.id.toString()) && (
            <span
              key={`${tag.id}-${index}`}
              className="bg-gray-200 px-2 py-1 rounded text-sm"
            >
              #{tag.name}
            </span>
          )
      )}
    </div>
  );
}
