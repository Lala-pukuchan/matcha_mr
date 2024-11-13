"use client";
import { useEffect, useState, useRef } from "react";
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";
import Link from "next/link";
import Action from "../components/action";
import useAuthCheck from "../hooks/useAuthCheck";
import useWebSocket from "../hooks/useWebSocket";

export default function MyAccount() {
  useAuthCheck("", "/login");
  const [user, setUser] = useState<{ 
    id: number; 
    status: string; 
    last_active: string; 
    tagIds: number[]; 
    profilePic: string; 
    pic1: string; 
    pic2: string; 
    pic3: string; 
    pic4: string; 
    pic5: string; 
    lastname: string; 
    firstname: string; 
    username: string;
    age: number; 
    gender: string; 
    preference: string; 
    isRealUser: boolean; 
    biography: string;
    latitude: number;
    longitude: number;
    match_ratio: number;
    fake_account: boolean;
    liked: string;
    matched: string;
  } | null>(null);

  const userRef = useRef(user);
  const [loading, setLoading] = useState(true);
  const [viewedFromUsers, setViewedFromUsers] = useState([]);
  const [likedFromUsers, setLikedFromUsers] = useState([]);
  const [userList, setUserList] = useState([]);
  const token = typeof window !== "undefined" ? document.cookie.split("; ").find((row) => row.startsWith("token=")) : null;
  const socket = useWebSocket(); 
  useEffect(() => {
    const fetchUser = async () => {
      console.log("fetchUser called");
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
      const userData = {
        ...data,
        latitude: parseFloat(data.latitude),
        longitude: parseFloat(data.longitude),
      };
      setUser(userData);
      console.log("user: ", userData);
    } else {
      setUser(null);
    }
      } catch (e) {
        setUser(null);
        console.error(e);
      } finally {
        setLoading(false);
      }
    };

    const fetchUsers = async () => {
      console.log("fetchUsers called");
      console.log("user: ", user);
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/getUser`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              gender: user?.gender,
              preference: user?.preference,
            }),
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

    if (token) {
      fetchUser();
      fetchUsers();
    }

  }, []);

  //if (token) {
  //  const socket = useWebSocket(); // ユーザー情報がセットされた後にWebSocketを初期化
  //}

  useEffect(() => {
    if (user && user.id) {
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
      <div>
      {user ? (
        <UserInfo user={{
            ...user,
            latitude: user.latitude.toString(),
            longitude: user.longitude.toString(),
        }} />
      ) : (
        <p>Loading user information...</p>
      )}
    </div>
      <div className="container mx-auto w-screen flex justify-center">
        <div className="flex flex-col m-10 space-y-4">
          <Link className="text-cyan-400" href="/updateProfile">
            Update your profile?
          </Link>
          {user && (
            <Link className="text-cyan-400" href={`/updatePassword?username=${user.username}`}>
              Update your password?
            </Link>
          )}
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
