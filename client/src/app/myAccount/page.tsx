"use client";
import { useEffect, useState, useRef } from "react";
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";
import Link from "next/link";
import Action from "../components/action";

export default function MyAccount() {
  // get user from context
  const [user, setUser] = useState([]);
  const userRef = useRef(user);

  // set loading
  const [loading, setLoading] = useState(true);

  // viewed from users
  const [viewedFromUsers, setViewedFromUsers] = useState([]);
  // liked from users
  const [likedFromUsers, setLikedFromUsers] = useState([]);

  // set user list
  const [userList, setUserList] = useState([]);
  const [socket, setSocket] = useState(null);

  useEffect(() => {
    // Socket.IOの初期化
    const newSocket = io('http://localhost:4000', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
    });

    newSocket.on('connect', () => {
      console.log('WebSocket connected');
    });

    newSocket.on('disconnect', () => {
      console.log('WebSocket disconnected');
    });

    setSocket(newSocket);

    return () => {
      if (newSocket) {
        if (userRef.current && userRef.current.id) {
          newSocket.emit('logout', userRef.current.id);
        }
        newSocket.close();
      }
    };
  }, []);

  useEffect(() => {
    if (socket && user && user.id) {
      console.log('Emitting login event');
      socket.emit('login', user.id);
    }
  }, [socket, user]);

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
          const userId = data.id;
          setUser(data);

          if (userId) {
            try {
              const userJson = JSON.stringify({ userId: userId });
              const response = await fetch(
                `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/viewed`,
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
                  setViewedFromUsers(responseData);
                }
              } else {
                console.error("updating viewed is failed");
              }
            } catch (e) {
              console.error(e);
            }
            try {
              const userJson = JSON.stringify({ userId: userId });
              const response = await fetch(
                `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/liked`,
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
                  setLikedFromUsers(responseData);
                }
              } else {
                console.error("updating liked is failed");
              }
            } catch (e) {
              console.error(e);
            }
          }
        } else {
          setUser([]);
        }
      } catch (e) {
        setUser([]);
        console.error(e);
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