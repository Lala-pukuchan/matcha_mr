"use client";
import { useEffect, useState } from "react";
import useWebSocket from "../hooks/useWebSocket";
import Geo from "./geo";
import Tag from "./tag";
import MatchRatio from "./matchRatio";

export default function UserInfo({ user }: { 
  user: { 
    id: number; 
    status: string; 
    last_active: string; 
    tagIds?: string[]; 
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
    biography: string; 
    latitude: number; 
    longitude: number; 
    match_ratio: number; 
    liked: string; 
    matched: string; 
    isRealUser: boolean 
  } 
}) {
  const [message, setMessage] = useState("");
  const [onlineStatus, setOnlineStatus] = useState(user.status || "offline");
  const [lastActive, setLastActive] = useState(user.last_active);

  const socket = useWebSocket();

  useEffect(() => {
    if (socket && user && user.id) {
      socket.on("user status", ({ userId, status }) => {
        if (userId === user.id) {
          setOnlineStatus(status);
          if (status === "offline") {
            const now = new Date().toISOString();
            setLastActive(now);
          }
        }
      });
    }

    return () => {
      if (socket) {
        socket.off("user status");
      }
    };
  }, [socket, user]);

  const formatDate = (dateString: string) => {
    const options = {
      year: "numeric",
      month: "long",
      day: "numeric",
      hour: "numeric",
      minute: "numeric",
    };
    const date = new Date(dateString);
    return date.toLocaleString("en-US",  {
      year: "numeric",
      month: "long",
      day: "numeric",
      hour: "numeric",
      minute: "numeric",
    });
  };

  return (
    <div className="container mx-auto flex justify-center px-4 md:px-0">
      <div className="flex flex-col space-y-6 max-w-md md:max-w-lg">
        <div className="flex justify-center">
          {user && user.profilePic ? (
            <img
              src={user.profilePic}
              alt="Profile Pic"
              className="h-72 w-72 md:h-80 md:w-80 object-cover rounded"
            />
          ) : (
            <div className="h-72 w-72 md:h-80 md:w-80 bg-gray-200 rounded">No Image</div>
          )}
        </div>

        <div className="grid grid-cols-5 gap-2 justify-center w-72 md:w-80 mx-auto">
          {[user.pic1, user.pic2, user.pic3, user.pic4, user.pic5].map(
            (pic, index) => (
              <div key={index} className="flex justify-center">
                {pic ? (
                  <img
                    src={pic}
                    alt={`pic${index + 1}`}
                    className="h-12 w-12 object-cover rounded"
                  />
                ) : (
                  <div className="h-12 w-12 bg-gray-200 rounded">No Image</div>
                )}
              </div>
            )
          )}
        </div>

        <div className="grid gap-4 grid-cols-2 mx-auto w-full">
          <p className="font-bold">Lastname</p>
          <p>{user ? user.lastname : ""}</p>
          <p className="font-bold">Firstname</p>
          <p>{user ? user.firstname : ""}</p>
          <p className="font-bold">Age</p>
          <p>{user ? user.age : ""}</p>
          <p className="font-bold">Gender</p>
          <p>{user ? user.gender : ""}</p>
          <p className="font-bold">Gender I Like</p>
          <p>{user ? user.preference : ""}</p>
          <p className="font-bold">Biography</p>
          <p>{user ? user.biography : ""}</p>
        </div>
        <div className="mx-auto w-full">
          <h2 className="font-bold">Tags</h2>
          {user.tagIds ? <Tag user={{ tagIds: user.tagIds }} /> : null}
        </div>

        <div className="grid gap-4 grid-cols-2 mx-auto w-full">
          <p className="font-bold">Location</p>
          {user && user.latitude && user.longitude ? (
            <Geo
            lat={user.latitude}
            lon={user.longitude}
            isRealUser={user.isRealUser}
            />
          ) : (
            ""
          )}
        </div>

        <div className="grid gap-4 grid-cols-2 mx-auto w-full">
          <p className="font-bold">Match Ratio</p>
          {user && user.match_ratio !== null && user.match_ratio !== undefined ? (
            <MatchRatio matchRatio={user.match_ratio} />
          ) : (
            ""
          )}
        </div>

        {user && user.liked ? (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Liked By Someone</p>
            <p>{user.liked}</p>
          </div>
        ) : (
          ""
        )}
        {user && user.matched ? (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Matched With Someone</p>
            <p>{user.matched}</p>
          </div>
        ) : (
          ""
        )}

        {onlineStatus && (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Last connected</p>
            <p>
              {onlineStatus === "online"
                ? "online"
                : lastActive
                ? formatDate(lastActive)
                : ""}
            </p>
          </div>
        )}

        <div className="text-red-500 mx-auto w-full">{message}</div>
      </div>
    </div>
  );
}
