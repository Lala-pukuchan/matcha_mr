"use client";
import { useEffect, useState } from "react";

export default function UserInfo({ user }) {
  console.log("user from userInfo", user);
  // set message
  const [message, setMessage] = useState("");

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
          setMessage(data.message);
        }
      } catch (e) {
        console.error(e);
      }
    }
    setCreatedTags();
  }, []);

  return (
    <div className="container mx-auto w-screen flex justify-center">
      <div className="flex flex-col m-10 space-y-4">
        <div className="grid grid-cols-1">
          {user && user.profilePic ? (
            <img
              src={user.profilePic}
              alt="Profile Pic"
              className="h-80 w-80 object-cover rounded"
            />
          ) : (
            <div className="h-80 w-80 bg-gray-200 rounded">No Image</div>
          )}
        </div>
        <div className="grid grid-cols-5">
          <div>
            {user && user.pic1 ? (
              <img
                src={user.pic1}
                alt="pic1"
                className="h-12 w-12 object-cover rounded"
              />
            ) : (
              <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
            )}
          </div>
          <div>
            {user && user.pic2 ? (
              <img
                src={user.pic2}
                alt="pic2"
                className="h-12 w-12 object-cover rounded"
              />
            ) : (
              <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
            )}
          </div>
          <div>
            {user && user.pic3 ? (
              <img
                src={user.pic3}
                alt="pic3"
                className="h-12 w-12 object-cover rounded"
              />
            ) : (
              <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
            )}
          </div>
          <div>
            {user && user.pic4 ? (
              <img
                src={user.pic4}
                alt="pic4"
                className="h-12 w-12 object-cover rounded"
              />
            ) : (
              <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
            )}
          </div>
          <div>
            {user && user.pic5 ? (
              <img
                src={user.pic5}
                alt="pic5"
                className="h-12 w-12 object-cover rounded"
              />
            ) : (
              <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
            )}
          </div>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">lastname</p>
          <p>{user ? user.lastname : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">firstname</p>
          <p>{user ? user.firstname : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">email</p>
          <p>{user ? user.email : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">Gender</p>
          <p>{user ? user.gender : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">Gender I Like</p>
          <p>{user ? user.preference : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <p className="font-bold">biography</p>
          <p>{user ? user.biography : ""}</p>
        </div>
        <div className="grid grid-cols-2">
          <div>
            <h2 className="font-bold">Tags</h2>
          </div>
          <div>
            <ul>
              {tags.map(
                (tag, index) =>
                  user &&
                  user.tagIds &&
                  user.tagIds.includes(tag.id.toString()) && (
                    <li key={`${tag.id}-${index}`}>
                      <p className="pl-2">#{tag.name}</p>
                    </li>
                  )
              )}
            </ul>
          </div>
        </div>
        <div className="text-red-500">{message}</div>
      </div>
    </div>
  );
}
