"use client";
import { useState, useEffect } from "react";
import { useUser } from "../../../context/context";
import UsersList from "../components/userList";
import AgeRangeSlider from "../components/ageRangeSlider";
import DistanceRangeSlider from "../components/distanceRangeSlider";
import FameRatingRangeSlider from "../components/fameRatingRangeSlider";
import TagSelection from "../components/tagSelection";
import useAuthCheck from "../hooks/useAuthCheck"; 

export default function Home() {
  const isRedirecting = useAuthCheck(null, "/login");
  const { user } = useUser();

  const [users, setUserList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [likedUsersId, setLikedUsersId] = useState([]);
  const [blockedUsersId, setBlockedUsersId] = useState([]);

  useEffect(() => {
    if (isRedirecting || !user) {
      return;
    }

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
        const userJson = JSON.stringify({ userId: user.id });
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/likedTo`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: userJson,
          }
        );
        if (response.ok) {
          const responseData = await response.json();
          if (responseData) {
            const likedUsersIdArray = responseData.map(
              (item) => item.liked_to_user_id
            );
            setLikedUsersId(likedUsersIdArray);
          }
        } else {
          console.error("updating liked is failed");
        }
      } catch (e) {
        console.error(e);
      }
    };

    const blockedUsers = async () => {
      try {
        const userJson = JSON.stringify({ userId: user.id });
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/blockedTo`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: userJson,
          }
        );
        if (response.ok) {
          const responseData = await response.json();
          if (responseData) {
            const blockedUsersIdArray = responseData.map(
              (item) => item.blocked_to_user_id
            );
            setBlockedUsersId(blockedUsersIdArray);
          }
        } else {
          console.error("updating liked is failed");
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

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    if (user) {
      formData.append("user", JSON.stringify(user));
    }
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/users/searchUser`,
        {
          method: "POST",
          body: formData,
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
            <div className="grid md:grid-cols-4 grid-cols-1 gap-4">
              <div className="m-3">
                <AgeRangeSlider />
              </div>
              <div className="m-3">
                <DistanceRangeSlider />
              </div>
              <div className="m-3">
                <FameRatingRangeSlider />
              </div>
              <div className="m-3">
                <TagSelection user={user} />
              </div>
            </div>
            <h1 className="font-bold text-cyan-400 mt-6">Sort By: </h1>
            <div className="grid md:grid-cols-3 grid-cols-1 gap-4">
              <div className="m-3">
                <ul>
                  <li>
                    <input
                      type="radio"
                      id="age"
                      name="sort"
                      value="age"
                    ></input>
                    <label htmlFor="age" className="pl-2">
                      Age
                    </label>
                  </li>
                  <li>
                    <input
                      type="radio"
                      id="distance"
                      name="sort"
                      value="distance"
                    ></input>
                    <label htmlFor="distance" className="pl-2">
                      Distance
                    </label>
                  </li>
                  <li>
                    <input
                      type="radio"
                      id="fameRating"
                      name="sort"
                      value="fameRating"
                    ></input>
                    <label htmlFor="fameRating" className="pl-2">
                      Matching Ratio
                    </label>
                  </li>
                  <li>
                    <input
                      type="radio"
                      id="tag"
                      name="sort"
                      value="tag"
                    ></input>
                    <label htmlFor="tag" className="pl-2">
                      Tag (Sorted by selected tags)
                    </label>
                  </li>
                </ul>
              </div>
            </div>
            <div className="flex items-center justify-between">
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
