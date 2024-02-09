"use client";
import { useEffect, useState } from "react";
import { useUser } from "../../../context/context";

export default function updateProfile() {
  // if user is not logged in, redirect to login page
  const [userId, setUserId] = useState("");
  const user = useUser();
  useEffect(() => {
    console.log("user: ", user);
    if (user) {
      setUserId(user.id);
    }
  }, [user]);

  // set message
  const [message, setMessage] = useState("");

  // set tags
  const [tags, setTags] = useState([]);
  const [inputTag, setInputTag] = useState("");

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
          setMessage(data.message);
        }
      } catch (e) {
        console.error(e);
      }
    }
    setCreatedTags();
  }, []);

  // change add tag value
  const handleChange = (event) => {
    setInputTag(event.target.value);
    setMessage("");
  };

  // add tag
  async function createNewTag() {
    if (inputTag === "") {
      setMessage("Please input tag name.");
    } else {
      const newTagJson = JSON.stringify({ name: inputTag });
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/tag`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: newTagJson,
          }
        );
        if (response.status === 200) {
          const newTag = await response.json();
          setTags([...tags, newTag]);
        } else {
          const data = await response.json();
          setMessage(data.message);
        }
      } catch (e) {
        console.error(e);
      }
    }
  }
  const addTag = (event) => {
    createNewTag();
  };

  // submit login form
  async function updateProfile(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/user/update`,
        {
          method: "POST",
          body: formData,
        }
      );
      if (response.status === 200) {
        window.location.href = "/myAccount"
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    } catch (e) {
      console.error(e);
    }
  }

  return (
    <div>
      <form
        onSubmit={updateProfile}
        encType="multipart/form-data"
        className="container mx-auto w-screen"
      >
        <input
          type="text"
          id="userId"
          name="userId"
          value={userId}
          className="hidden"
          readOnly
        />
        <div className="flex flex-col m-10 space-y-4">
          <label htmlFor="gender" className="font-bold">
            Gender
          </label>
          <div className="p-3 rounded">
            <input
              type="radio"
              id="male"
              name="gender"
              value="male"
              className="m-1"
            />
            <label htmlFor="male">Male</label>
            <input
              type="radio"
              id="female"
              name="gender"
              value="female"
              className="m-1"
            />
            <label htmlFor="female">Female</label>
          </div>
          <label htmlFor="preference" className="font-bold">
            Gender You Like
          </label>
          <div className="p-3 rounded">
            <input
              type="radio"
              id="male-pre"
              name="preference"
              value="male"
              className="m-1"
            />
            <label htmlFor="male-pre">Male</label>
            <input
              type="radio"
              id="female-pre"
              name="preference"
              value="female"
              className="m-1"
            />
            <label htmlFor="female-pre">Female</label>
          </div>
          <label htmlFor="biography" className="font-bold">
            biography
          </label>
          <input
            type="text"
            id="biography"
            name="biography"
            placeholder="biography"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <div>
            <h2 className="font-bold">Tags</h2>
            <ul>
              {tags.map((tag) => (
                <li key={tag.id}>
                  <input
                    id={tag.id}
                    type="checkbox"
                    value={tag.name}
                    name="tags"
                  ></input>
                  <label htmlFor={tag.id} className="pl-2">
                    {tag.name}
                  </label>
                </li>
              ))}
            </ul>
            <input
              type="text"
              id="addingTag"
              name="addingTag"
              value={inputTag}
              onChange={handleChange}
              placeholder="#camping"
              className="bg-gray-100 p-3 rounded inline-block"
            />
            <button
              onClick={addTag}
              className="m-3 w-40 h-9 rounded bg-cyan-400 text-white inline-block"
            >
              Add tag
            </button>
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="profilePicture" className="font-bold">
              Profile Picture
            </label>
            <input
              type="file"
              id="profilePicture"
              name="profilePicture"
              placeholder="profilePicture"
              accept="image/*"
              required
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="picture1" className="font-bold">
              Picture1
            </label>
            <input
              type="file"
              id="picture1"
              name="picture1"
              placeholder="picture1"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="picture2" className="font-bold">
              Picture2
            </label>
            <input
              type="file"
              id="picture2"
              name="picture2"
              placeholder="picture2"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="picture3" className="font-bold">
              Picture3
            </label>
            <input
              type="file"
              id="picture3"
              name="picture3"
              placeholder="picture3"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="picture4" className="font-bold">
              Picture4
            </label>
            <input
              type="file"
              id="picture4"
              name="picture4"
              placeholder="picture4"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="picture5" className="font-bold">
              Picture5
            </label>
            <input
              type="file"
              id="picture5"
              name="picture5"
              placeholder="picture5"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
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
