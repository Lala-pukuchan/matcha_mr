import { useState, useEffect } from "react";

export default function TagSelection({ user }: { user: { tagIds: number[] } }) {
  // set tags
  const [tags, setTags] = useState<{id: number, name: string}[]>([]);

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
      <label htmlFor="fameRating" className="text-gray-400 font-bold">
        Tag
      </label>
      <br />
      <div className="text-gray-400">
        {tags.map((tag, index) => (
          <div key={`${tag.id}-${index}`} className="flex items-center mb-2">
            <input
              type="checkbox"
              id={`tag-${tag.id}`}
              name="tagIds"
              value={tag.id}
              defaultChecked={user?.tagIds?.includes(tag.id)}
              className="checkbox-input"
            />
            <label htmlFor={`tag-${tag.id}`} className="pl-2">
              #{tag.name}
            </label>
          </div>
        ))}
      </div>
    </div>
  );
}
