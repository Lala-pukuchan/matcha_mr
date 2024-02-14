"use client";
import { useState, useEffect } from "react";
import { useUser } from "../../context/context";
import UsersList from "./components/userList";

export default function Home() {
  // get user from context
  const { user, setUser } = useUser();
  // set user list
  const [users, setUserList] = useState([]);
  // set loading
  const [loading, setLoading] = useState(true);
  // set liked users
  const [likedUsersId, setLikedUsersId] = useState([]);

  // check user
  useEffect(() => {
    const checkUser = async () => {
      await new Promise((resolve) => setTimeout(resolve, 2000));
      setLoading(false);
      if (!user) {
        window.location.href = "/login";
      }
    };
    const fetchUsers = async () => {
      console.log("fetching users", user);
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users`,
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
          `${process.env.NEXT_PUBLIC_API_URL}/api/user/likedTo`,
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

    checkUser();
    fetchUsers();
    likedUsers();
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <div className="flex justify-center">
        <div className="text-pink-400">
          {user ? (
            <p>You have already loggedin, {user.username}</p>
          ) : (
            <p>Please log in</p>
          )}
        </div>
      </div>
      <div className="container mx-auto w-screen flex justify-center">
        <UsersList
          users={users}
          operationUserId={user.id}
          likedUsersId={likedUsersId}
        />
      </div>
    </>
  );
}
