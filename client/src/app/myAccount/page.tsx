"use client";
import { useEffect, useState } from "react";
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";
import Link from "next/link";
import Action from "../components/action";

export default function myAccount() {
  // get user from context
  const { user, setUser } = useUser();

  // set loading
  const [loading, setLoading] = useState(true);

  // viewed from users
  const [viewedFromUsers, setViewedFromUsers] = useState([]);
  // liked from users
  const [likedFromUsers, setLikedFromUsers] = useState([]);

  // set user list
  const [userList, setUserList] = useState([]);

  // check user
  useEffect(() => {
    const checkUser = async () => {
      await new Promise((resolve) => setTimeout(resolve, 2000));
      setLoading(false);
      if (!user) {
        window.location.href = "/login";
      } else {
        try {
          const userJson = JSON.stringify({ userId: user.id });
          const response = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/user/viewed`,
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: userJson,
            }
          );
          console.log("response: ", response);
          if (response.ok) {
            const responseData = await response.json();
            if (responseData) {
              setViewedFromUsers(responseData);
              console.log("viewedFromUsers: ", responseData);
            }
          } else {
            console.error("updating viewed is failed");
          }
        } catch (e) {
          console.error(e);
        }
        try {
          const userJson = JSON.stringify({ userId: user.id });
          const response = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/user/liked`,
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: userJson,
            }
          );
          console.log("response: ", response);
          if (response.ok) {
            const responseData = await response.json();
            if (responseData) {
              setLikedFromUsers(responseData);
              console.log("likedFromUsers: ", responseData);
            }
          } else {
            console.error("updating liked is failed");
          }
        } catch (e) {
          console.error(e);
        }
      }
    };
    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users`
        );
        if (response.ok) {
          const data = await response.json();
          setUserList(data);
          console.log("userList: ", data);
        } else {
          setUserList([]);
        }
      } catch (e) {
        setUserList([]);
        console.error(e);
      }
    };

    checkUser();
    fetchUsers();
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }
  return (
    <>
      {user ? <UserInfo user={user} /> : <div>Loading...</div>}
      <div className="container mx-auto w-screen flex justify-center">
        <div className="flex flex-col m-10 space-y-4">
          <Link className="text-cyan-400" href="/updateProfile">
            Update your profile?
          </Link>
          <div className="grid grid-cols-2">
            <div>
              <h2 className="text-pink-400">Viewed By</h2>
            </div>
            <Action userList={userList} targetUsers={viewedFromUsers} />
          </div>
          <div className="grid grid-cols-2">
            <div>
              <h2 className="text-pink-400">Liked By</h2>
            </div>
            <Action userList={userList} targetUsers={likedFromUsers} />
          </div>
        </div>
      </div>
    </>
  );
}
