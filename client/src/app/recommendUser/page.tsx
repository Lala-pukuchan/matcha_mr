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

  const [users, setUsers] = useState([]);
  const [sortedUsers, setSortedUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [likedUsersId, setLikedUsersId] = useState([]);
  const [blockedUsersId, setBlockedUsersId] = useState([]);
  const [tags, setTags] = useState([]);
  const [selectedTags, setSelectedTags] = useState([]);
  const [ageRange, setAgeRange] = useState([]);
  const [distanceRange, setDistanceRange] = useState([0, 100]);
  const [fameRatingRange, setFameRatingRange] = useState([20, 100]);

  const [showAgeRange, setShowAgeRange] = useState(false);
  const [showDistanceRange, setShowDistanceRange] = useState(false);
  const [showFameRating, setShowFameRating] = useState(false);
  const [showTags, setShowTags] = useState(false);
  const [minAge, setMinAge] = useState(18);
  const [maxAge, setMaxAge] = useState(60);

  const [sortOption, setSortOption] = useState("");
  const [sortOrder, setSortOrder] = useState("asc");

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
        const min_age = Math.max(18, user.age - 10);
        const max_age = Math.min(100, user.age + 10);
        setAgeRange([min_age, max_age]);
        setMinAge(min_age);
        setMaxAge(max_age);

        const formData = {
          user: JSON.stringify(user),
          min_age: min_age,
          max_age: max_age,
          min_distance: 0,
          max_distance: 1000,
          min_fame_rating: 20,
          max_fame_rating: 100,
          min_common_tag_count: 1,
        };

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
        if (response.ok) {
          const data = await response.json();
          setUsers(data.filter((d) => d.id !== user.id));
        } else {
          setUsers([]);
        }
      } catch (e) {
        setUsers([]);
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

  useEffect(() => {
    const sorted = [...users].sort((a, b) => {
      if (sortOption === "age") {
        return sortOrder === "asc" ? a.age - b.age : b.age - a.age;
      } else if (sortOption === "location") {
        return sortOrder === "asc" ? a.distance - b.distance : b.distance - a.distance;
      } else if (sortOption === "fameRating") {
        return sortOrder === "asc" ? a.match_ratio - b.match_ratio : b.match_ratio - a.match_ratio;
      } else if (sortOption === "commonTags") {
        return sortOrder === "asc" ? a.common_tags_count - b.common_tags_count : b.common_tags_count - a.common_tags_count;
      }
      return 0;
    });
    setSortedUsers(sorted);
  }, [sortOption, sortOrder, users]);

  async function handleSubmit(event) {
    event.preventDefault();

    const formData = {
      user: JSON.stringify(user),
      min_age: showAgeRange ? ageRange[0] : minAge,
      max_age: showAgeRange ? ageRange[1] : maxAge,
      min_distance: showDistanceRange ? distanceRange[0] : 0,
      max_distance: showDistanceRange ? distanceRange[1] : 1000,
      min_fame_rating: showFameRating ? fameRatingRange[0] : 20,
      max_fame_rating: showFameRating ? fameRatingRange[1] : 100,
      min_common_tag_count: 1,
      ...(showTags && { tags: selectedTags.map((tag: { value: string }) => tag.value) }),
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
        setUsers(data.filter((d) => d.id !== user.id));
      } else {
        const data = await response.json();
        console.log("message", data.message);
        setUsers([]);
      }
    } catch (e) {
      console.log("error: ", e);
      setUsers([]);
    }
  }

  if (isRedirecting || loading) {
    return <div>Loading...</div>;
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
              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="ageRange"
                  checked={showAgeRange}
                  onChange={() => setShowAgeRange(!showAgeRange)}
                />
                <label htmlFor="ageRange" className="ml-2">Age Range</label>
              </div>
              {showAgeRange && (
                <div className="flex flex-col">
                  <Slider
                    className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                    thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                    trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                    value={ageRange}
                    min={minAge}
                    max={maxAge}
                    onChange={setAgeRange}
                    pearling
                    minDistance={1}
                  />
                  <div>{`Min: ${ageRange[0]}, Max: ${ageRange[1]}`}</div>
                </div>
              )}

              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="distanceRange"
                  checked={showDistanceRange}
                  onChange={() => setShowDistanceRange(!showDistanceRange)}
                />
                <label htmlFor="distanceRange" className="ml-2">Distance Range</label>
              </div>
              {showDistanceRange && (
                <div className="flex flex-col">
                  <Slider
                    className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                    thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                    trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                    value={distanceRange}
                    min={0}
                    max={100}
                    onChange={setDistanceRange}
                    pearling
                    minDistance={1}
                  />
                  <div>{`Min: ${distanceRange[0]} km, Max: ${distanceRange[1]} km`}</div>
                </div>
              )}

              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="fameRating"
                  checked={showFameRating}
                  onChange={() => setShowFameRating(!showFameRating)}
                />
                <label htmlFor="fameRating" className="ml-2">Fame Rating</label>
              </div>
              {showFameRating && (
                <div className="flex flex-col">
                  <Slider
                    className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
                    thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
                    trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
                    value={fameRatingRange}
                    min={20}
                    max={100}
                    onChange={setFameRatingRange}
                    pearling
                    minDistance={1}
                  />
                  <div>{`Min: ${fameRatingRange[0]}, Max: ${fameRatingRange[1]}`}</div>
                </div>
              )}

              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="tags"
                  checked={showTags}
                  onChange={() => setShowTags(!showTags)}
                />
                <label htmlFor="tags" className="ml-2">Tags</label>
              </div>
              {showTags && (
                <div className="flex flex-col mt-4">
                  <Select
                    isMulti
                    name="tags"
                    options={tags}
                    className="basic-multi-select"
                    classNamePrefix="select"
                    onChange={setSelectedTags}
                  />
                </div>
              )}
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
      <div className="flex justify-center">
        <div className="w-full max-w-5xl">
          <form className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <h1 className="font-bold text-cyan-400">Sort By: </h1>
            <div className="grid grid-cols-1 gap-4">
              <div className="flex items-center">
                <input
                  type="radio"
                  name="sortOption"
                  id="age"
                  value="age"
                  onChange={(e) => setSortOption(e.target.value)}
                />
                <label htmlFor="age" className="ml-2">Age</label>
              </div>
              <div className="flex items-center">
                <input
                  type="radio"
                  name="sortOption"
                  id="distance"
                  value="location"
                  onChange={(e) => setSortOption(e.target.value)}
                />
                <label htmlFor="distance" className="ml-2">Distance</label>
              </div>
              <div className="flex items-center">
                <input
                  type="radio"
                  name="sortOption"
                  id="fameRatingSort"
                  value="fameRating"
                  onChange={(e) => setSortOption(e.target.value)}
                />
                <label htmlFor="fameRatingSort" className="ml-2">Fame Rating</label>
              </div>
              <div className="flex items-center">
                <input
                  type="radio"
                  name="sortOption"
                  id="common_tag_count"
                  value="commonTags"
                  onChange={(e) => setSortOption(e.target.value)}
                />
                <label htmlFor="common_tag_count" className="ml-2">Common Tag Count</label>
              </div>
            </div>
            <div className="flex items-center mt-4">
              <label htmlFor="sortOrder" className="mr-2">Order:</label>
              <select
                id="sortOrder"
                value={sortOrder}
                onChange={(e) => setSortOrder(e.target.value)}
                className="ml-2"
              >
                <option value="asc">Ascending</option>
                <option value="desc">Descending</option>
              </select>
            </div>
          </form>
        </div>
      </div>
      <div className="container mx-auto w-screen flex justify-center">
        <UsersList
          users={sortedUsers}
          operationUserId={user.id}
          likedUsersId={likedUsersId}
          blockedUsersId={blockedUsersId}
          link="/users"
        />
      </div>
    </>
  );
}
