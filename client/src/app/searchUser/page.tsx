"use client";
import { useState, useEffect } from "react";
import Select from "react-select";
import Slider from "react-slider";
import { useUser } from "../../../context/context";
import UsersList from "../components/userList";
import useAuthCheck from "../hooks/useAuthCheck";
interface User {
  id: string; 
  status: string;
  tagIds?: string[];
  profilePic?: string;
  username: string;
  age: number;
  match_ratio: number;
  latitude: number;
  longitude: number;
  isRealUser: boolean;
  fake_account: boolean;
  distance: number;
  common_tags_count: number;
}
export default function Home() {
  const isRedirecting = useAuthCheck("", "/login");
  const { user } = useUser();
  const [users, setUserList] = useState<User[]>([]);
  const [sortedUsers, setSortedUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [likedUsersId, setLikedUsersId] = useState<number[]>([]);
  const [blockedUsersId, setBlockedUsersId] = useState<number[]>([]);
  const [blockedToUsersId, setBlockedToUsersId] = useState<number[]>([]);
  const [tags, setTags] = useState<{ value: number; label: string }[]>([]);
  const [selectedTags, setSelectedTags] = useState<{ value: number; label: string }[]>([]);
  const [ageRange, setAgeRange] = useState<[number, number]>([18, 60]);
  const [distanceRange, setDistanceRange] = useState([0, 100]);
  const [fameRatingRange, setFameRatingRange] = useState([0, 100]);

  const [showAgeRange, setShowAgeRange] = useState(false);
  const [showDistanceRange, setShowDistanceRange] = useState(false);
  const [showFameRating, setShowFameRating] = useState(false);
  const [showTags, setShowTags] = useState(false);

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
          setTags(data.map((tag: { id: number; name: string }) => ({ value: tag.id, label: tag.name })));
        } else {
          console.error("Failed to fetch tags");
        }
      } catch (e) {
        console.error(e);
      }
    };

    fetchTags();

    const fetchUsers = async () => {

      const formData = {
        user: JSON.stringify(user),
      };

      try {
        //const response = await fetch(
        //  `${process.env.NEXT_PUBLIC_API_URL}/api/users/getUser`,
        //  {
        //    method: "POST",
        //    headers: {
        //      "Content-Type": "application/json",
        //    },
        //    body: JSON.stringify({
        //      gender: user.gender,
        //      preference: user.preference,
        //    }),
        //  }
        //);
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
          setUserList(data.filter((d: { id: number }) => d.id !== user.id));
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
          setLikedUsersId(responseData.map((item: { liked_to_user_id: number }) => item.liked_to_user_id));
        }
      } catch (e) {
        console.error(e);
      }
    };

    const blockedFromUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/blockedFrom`,
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
          setBlockedUsersId(responseData.map((item: { from_user_id: number }) => item.from_user_id));
        }
      } catch (e) {
        console.error(e);
      }
    };

    const blockedToUsers = async () => {
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
          setBlockedToUsersId(responseData.map((item: { blocked_to_user_id: number }) => item.blocked_to_user_id));
        }
      } catch (e) {
        console.error(e);
      }
    };

    if (user) {
      //fetchUsers();
      likedUsers();
      blockedFromUsers();
      blockedToUsers();
      setLoading(false);
    }
  }, [user, isRedirecting]);

  useEffect(() => {
    //console.log('called');
    //console.log(users);
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

  if (isRedirecting || loading) {
    return <div>Loading...</div>;
  }

  async function handleSubmit(event: React.FormEvent) {
    event.preventDefault();

    const formData = {
      user: JSON.stringify(user),
      // Conditionally add properties based on the selection
      ...(showAgeRange && { min_age: ageRange[0], max_age: ageRange[1] }),
      ...(showDistanceRange && { min_distance: distanceRange[0], max_distance: distanceRange[1] }),
      ...(showFameRating && { min_fame_rating: fameRatingRange[0], max_fame_rating: fameRatingRange[1] }),
      ...(showTags && { tags: selectedTags.map((tag: { value: number }) => tag.value) }),
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
        setUserList(data.filter((d: { id: number }) => d.id !== user.id));
      } else {
        const data = await response.json();
        //console.log("message", data.message);
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
                    min={18}
                    max={100}
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
                    max={10000}
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
                    min={0}
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
                    onChange={(newValue) => setSelectedTags(newValue as { value: number; label: string }[])}
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
          operationUserId={user.id.toString()}
          likedUsersId={likedUsersId.map(String)}
          blockedUsersId={blockedUsersId.map(String)}
          blockedToUsersId={blockedToUsersId.map(String)}
          link="/users"
        />
      </div>
    </>
  );
}
