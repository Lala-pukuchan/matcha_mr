"use client";
import { useEffect, useState, useRef } from "react";
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";
import Link from "next/link";
import Action from "../components/action";
import useAuthCheck from "../hooks/useAuthCheck";
import useWebSocket from "../hooks/useWebSocket";

export default function MyAccount() {
  useAuthCheck(null, "/login");
  const [user, setUser] = useState([]);
  const userRef = useRef(user);
  const [loading, setLoading] = useState(true);
  const [viewedFromUsers, setViewedFromUsers] = useState([]);
  const [likedFromUsers, setLikedFromUsers] = useState([]);
  const [userList, setUserList] = useState([]);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/myAccount`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            credentials: "include",
          }
        );
        if (response.ok) {
          const data = await response.json();
          setUser(data);
        } else {
          setUser([]);
        }
      } catch (e) {
        setUser([]);
        console.error(e);
      } finally {
        setLoading(false);
      }
    };

    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/getUser`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
          }
        );
        if (response.ok) {
          const data = await response.json();
          setUserList(data);
        } else {
          setUserList([]);
        }
      } catch (e) {
        setUserList([]);
        console.error(e);
      }
    };

    fetchUser();
    fetchUsers();
  }, []);

  const socket = useWebSocket(); // ユーザー情報がセットされた後にWebSocketを初期化

  useEffect(() => {
    if (user.id) {
      const fetchData = async () => {
        try {
          const userJson = JSON.stringify({ userId: user.id });
          const viewedResponse = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/viewed`,
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: userJson,
            }
          );
          if (viewedResponse.ok) {
            const responseData = await viewedResponse.json();
            setViewedFromUsers(responseData);
          }
          const likedResponse = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/liked`,
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: userJson,
            }
          );
          if (likedResponse.ok) {
            const responseData = await likedResponse.json();
            setLikedFromUsers(responseData);
          }
        } catch (e) {
          console.error(e);
        }
      };
      fetchData();
    }
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <UserInfo user={user} />
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
