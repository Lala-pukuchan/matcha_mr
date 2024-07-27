"use client";
import { useState, useEffect } from "react";
import { useUser } from "../../context/context";
import UsersList from "./components/userList";
import { connect } from "http2";
import { connected } from "process";

export default function Home() {
  // get user from context
  const { user, setUser } = useUser();
  // set user list
  const [connectedUsers, setUserListConnected] = useState([]);
  const [users, setUserListClose] = useState([]);
  const [usersCommonTags, setUsersCommonTags] = useState([]);
  const [usersFrequentlyLikedBack, setUsersFrequentlyLikedBack] = useState([]);

  // set loading
  const [loading, setLoading] = useState(true);
  // set liked users
  const [likedUsersId, setLikedUsersId] = useState([]);
  // set blocked users
  const [blockedUsersId, setBlockedUsersId] = useState([]);

  // check user
  useEffect(() => {
    const checkUser = async () => {
      if (!user || !user.id) {
        window.location.href = "/login";
        return;
      }
      await new Promise((resolve) => setTimeout(resolve, 2000));
      setLoading(false);
      const token = document.cookie
      .split("; ")
      .find((row) => row.startsWith("token="));
      console.log("token: ", token);
      if (!token) {
        console.log("no token");
        window.location.href = "/login";
      }
    };
    
    const fetchConnectedUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/connected`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              id: user.id,
            }),
          }
          );
          if (response.ok) {
            const data = await response.json();
            setUserListConnected(data.filter((d) => d.id !== user.id));

        } else {
          setUserListConnected([]);
        }
      } catch (e) {
        setUserListConnected([]);
        console.error(e);
      }
    };

    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/close`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              gender: user.gender,
              preference: user.preference,
              latitude: user.latitude,
              longitude: user.longitude,
            }),
          }
        );
        if (response.ok) {
          const data = await response.json();
          setUserListClose(data.filter((d) => d.id !== user.id));
        } else {
          setUserListClose([]);
        }
      } catch (e) {
        setUserListClose([]);
        console.error(e);
      }
    };

    const fetchUsersCommon = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/commonTags`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              gender: user.gender,
              preference: user.preference,
              tagIds: user.tagIds,
            }),
          }
        );
        if (response.ok) {
          const data = await response.json();
          setUsersCommonTags(data.filter((d) => d.id !== user.id));
        } else {
          setUsersCommonTags([]);
        }
      } catch (e) {
        setUsersCommonTags([]);
        console.error(e);
      }
    };

    const fetchUsersFrequentlyLikedBack = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/frequentlyLikedBack`,
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
          setUsersFrequentlyLikedBack(data.filter((d) => d.id !== user.id));
        } else {
          setUsersFrequentlyLikedBack([]);
        }
      } catch (e) {
        setUsersFrequentlyLikedBack([]);
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
          `${process.env.NEXT_PUBLIC_API_URL}/api/user/blockedTo`,
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

    checkUser();

    if (user) {
      fetchUsers();
      fetchConnectedUsers();
      fetchUsersCommon();
      fetchUsersFrequentlyLikedBack();
      likedUsers();
      blockedUsers();
    }
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <div>
        <hr />
        <div className="container mx-auto w-screen flex justify-center">
          <h1 className="text-pink-400 font-bold">
            User Connected With You! (You can start the chat)
          </h1>
        </div>
        <div className="container mx-auto w-screen flex justify-center">
          <UsersList
            users={connectedUsers}
            operationUserId={user.id}
            likedUsersId={likedUsersId}
            blockedUsersId={blockedUsersId}
            link="/chat"
          />
        </div>
      </div>
      <div>
        <hr />
        <div className="container mx-auto w-screen flex justify-center">
          <h1 className="text-pink-400 font-bold">User Close To You</h1>
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
      </div>
      <hr />
      <div className="mt-3">
        <div className="container mx-auto w-screen flex justify-center">
          <h1 className="text-pink-400 font-bold">User Having Common Tags</h1>
        </div>
        <div className="container mx-auto w-screen flex justify-center">
          <UsersList
            users={usersCommonTags}
            operationUserId={user.id}
            likedUsersId={likedUsersId}
            blockedUsersId={blockedUsersId}
            link="/users"
          />
        </div>
      </div>
      <hr />
      <div className="mt-3">
        <div className="container mx-auto w-screen flex justify-center">
          <h1 className="text-pink-400 font-bold">
            User Having High Match Rate
          </h1>
        </div>
        <div className="container mx-auto w-screen flex justify-center">
          <UsersList
            users={usersFrequentlyLikedBack}
            operationUserId={user.id}
            likedUsersId={likedUsersId}
            blockedUsersId={blockedUsersId}
            link="/users"
          />
        </div>
      </div>
    </>
  );
}
