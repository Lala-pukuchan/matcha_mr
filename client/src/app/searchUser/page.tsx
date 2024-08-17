"use client";
import { useState, useEffect } from "react";
import Select from "react-select";
import Slider from "react-slider";
import { useUser } from "../../../context/context";
import UsersList from "../components/userList";
import useAuthCheck from "../hooks/useAuthCheck";

export default function Home() {
  const isRedirecting = useAuthCheck(null, "/login");
  const { user } = useUser();

  const [users, setUserList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [likedUsersId, setLikedUsersId] = useState([]);
  const [blockedUsersId, setBlockedUsersId] = useState([]);
  const [tags, setTags] = useState([]);
  const [selectedTags, setSelectedTags] = useState([]);
  const [ageRange, setAgeRange] = useState([18, 60]);
  const [distanceRange, setDistanceRange] = useState([0, 100]);
  const [fameRatingRange, setFameRatingRange] = useState([0, 100]);

  useEffect(() => {
    if (isRedirecting || !user) {
      return;
    }

    const fetchTags = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/tags`);
        if (response.ok) {
          const data = await response.json();
          setTags(data.map(tag => ({ value: tag.id, label: tag.name })));
        } else {
          console.error("Failed to fetch tags");
        }
      } catch (e) {
        console.error(e);
      }
    };

    fetchTags();

    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/getUser`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              gender: user.gender,
              preference: user.preference,
            }),
          }
        );
        if (response.ok) {
          const data = await response.json();
          setUserList(data.filter((d) => d.id !== user.id));
        } else {
          setUserList([]);
        }
      } catch (e) {
        setUserList([]);
        console.error(e);
      }
    };

    const likedUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/likedTo`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ userId: user.id }),
          }
        );
        if (response.ok) {
          const responseData = await response.json();
          setLikedUsersId(responseData.map(item => item.liked_to_user_id));
        }
      } catch (e) {
        console.error(e);
      }
    };

    const blockedUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/blockedTo`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ userId: user.id }),
          }
        );
        if (response.ok) {
          const responseData = await response.json();
          setBlockedUsersId(responseData.map(item => item.blocked_to_user_id));
        }
      } catch (e) {
        console.error(e);
      }
    };

    if (user) {
      fetchUsers();
      likedUsers();
      blockedUsers();
      setLoading(false);
    }
  }, [user, isRedirecting]);

  if (isRedirecting || loading) {
    return <div>Loading...</div>;
  }

  async function handleSubmit(event) {
    event.preventDefault();
  
    const formData = {
      user: JSON.stringify(user),
      min_age: ageRange[0],
      max_age: ageRange[1],
      min_distance: distanceRange[0],
      max_distance: distanceRange[1],
      min_fame_rating: fameRatingRange[0],
      max_fame_rating: fameRatingRange[1],
      tags: selectedTags.map(tag => tag.value),
    };
  
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/users/searchUser`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(formData),
          credentials: "include",
        }
      );
  
      if (response.status === 200) {
        const data = await response.json();
        setUserList(data.filter((d) => d.id !== user.id));
      } else {
        const data = await response.json();
        console.log("message", data.message);
        setUserList([]);
      }
    } catch (e) {
      console.log("error: ", e);
      setUserList([]);
    }
  }  

  return (
    <>
      <div className="flex justify-center">
        <div className="w-full max-w-5xl">
          <form
            className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
            onSubmit={handleSubmit}
          >
            <h1 className="font-bold text-cyan-400">Filter By: </h1>
            <div className="grid grid-cols-1 gap-4">
              <div className="flex flex-col">
                <label>Age Range</label>
                <Slider
                  className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                  thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                  trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                  value={ageRange}
                  min={18}
                  max={100}
                  onChange={setAgeRange}
                  pearling
                  minDistance={1}
                />
                <div>{`Min: ${ageRange[0]}, Max: ${ageRange[1]}`}</div>
              </div>
              <div className="flex flex-col">
                <label>Distance Range</label>
                <Slider
                  className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                  thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                  trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                  value={distanceRange}
                  min={0}
                  max={10000}
                  onChange={setDistanceRange}
                  pearling
                  minDistance={1}
                />
                <div>{`Min: ${distanceRange[0]} km, Max: ${distanceRange[1]} km`}</div>
              </div>
              <div className="flex flex-col">
                <label>Fame Rating</label>
                <Slider
                  className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                  thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                  trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                  value={fameRatingRange}
                  min={0}
                  max={100}
                  onChange={setFameRatingRange}
                  pearling
                  minDistance={1}
                />
                <div>{`Min: ${fameRatingRange[0]}, Max: ${fameRatingRange[1]}`}</div>
              </div>
              <div className="flex flex-col mt-4">
                <label>Tags</label>
                <Select
                  isMulti
                  name="tags"
                  options={tags}
                  className="basic-multi-select"
                  classNamePrefix="select"
                  onChange={setSelectedTags}
                />
              </div>
            </div>
            <div className="flex items-center justify-between mt-4">
              <button
                type="submit"
                className="mt-4 w-60 h-9 rounded bg-pink-400 text-white"
              >
                Search
              </button>
            </div>
          </form>
        </div>
      </div>
      <div className="container mx-auto w-screen flex justify-center">
        <UsersList
          users={users}
          operationUserId={user.id}
          likedUsersId={likedUsersId}
          blockedUsersId={blockedUsersId}
          link="/users"
        />
      </div>
    </>
  );
}
