"use client";
import { useEffect, useState } from "react";

export default function updateProfile() {
  // set message
  const [message, setMessage] = useState("");

  // set tags
  const [tags, setTags] = useState([]);
  const [inputTag, setInputTag] = useState("");

  // set created tags
  useEffect(() => {
    async function setCreatedTags() {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/tags`
      );
      if (response.status === 200) {
        const data = await response.json();
        setTags(data);
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    }
    setCreatedTags();
  }, []);

  // change add tag value
  const handleChange = (event) => {
    setInputTag(event.target.value);
  };

  // add tag
  async function createNewTag() {
    const newTagJson = JSON.stringify({ name: inputTag });
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/tag`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: newTagJson,
    });
    if (response.status === 200) {
      const newTag = await response.json();
      setTags([...tags, newTag]);
    } else {
      const data = await response.json();
      setMessage(data.message);
    }
  }
  const addTag = (event) => {
    createNewTag();
  };

  // submit login form
  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_API_URL}/api/user/update`,
      {
        method: "POST",
        body: formData,
      }
    );
    if (response.status === 200) {
      window.location.href =
        "/login?message=Please enable your account via email";
    } else {
      const data = await response.json();
      setMessage(data.message);
    }
  }

  return (
    <div>
      <form onSubmit={onSubmit} className="container mx-auto w-screen">
        <div className="flex flex-col m-10 space-y-4">
          <label htmlFor="gender">Gender</label>
          <div className="bg-gray-100 p-3 rounded">
            <input type="radio" id="male" name="gender" value="male" />
            <label htmlFor="male">Male</label>
            <input type="radio" id="female" name="gender" value="female" />
            <label htmlFor="female">Female</label>
          </div>
          <label htmlFor="preference">Like</label>
          <div className="bg-gray-100 p-3 rounded">
            <input type="radio" id="male" name="preference" value="male" />
            <label htmlFor="male">Male</label>
            <input type="radio" id="female" name="preference" value="female" />
            <label htmlFor="female">Female</label>
          </div>
          <label htmlFor="biography">biography</label>
          <input
            type="text"
            id="biography"
            name="biography"
            placeholder="biography"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <div>
            <h2>Tags:</h2>
            <ul>
              {tags.map((tag) => (
                <li key={tag.id}>
                  <input id={tag.id} type="checkbox" value={tag.name}></input>
                  <label htmlFor={tag.id} className="pl-2">
                    {tag.name}
                  </label>
                </li>
              ))}
            </ul>
          </div>
          <label htmlFor="addingTag">addingTag</label>
          <input
            type="text"
            id="addingTag"
            name="addingTag"
            value={inputTag}
            onChange={handleChange}
            placeholder="addingTag"
            className="bg-gray-100 p-3 rounded inline-block"
          />
          <button
            onClick={addTag}
            className="w-40 h-9 rounded bg-pink-400 text-white inline-block"
          >
            Add tag
          </button>

          <button
            type="submit"
            className="w-40 h-9 rounded bg-pink-400 text-white"
          >
            Update
          </button>
          <div className="text-red-500">{message}</div>
        </div>
      </form>
    </div>
  );
}
