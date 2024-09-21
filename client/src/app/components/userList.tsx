import Link from "next/link";
import Heart from "./heart";
import Geo from "./geo";
import Tag from "./tag";
import MatchRatio from "./matchRatio";
import ReportFakeAccount from "./reportFakeAccount";
import Block from "./block";
import useWebSocket from "../hooks/useWebSocket";
import { useState, useEffect } from "react";
import { useDispatch } from 'react-redux';
import { addNotification } from '../store/notificationSlice';

export default function UsersList({
  users,
  operationUserId,
  likedUsersId,
  blockedUsersId,
  link,
}) {
  const [onlineStatus, setOnlineStatus] = useState({});
  const socket = useWebSocket();
  const dispatch = useDispatch();

  useEffect(() => {
    if (users && users.length > 0) {
      const userIds = users.map((user) => user.id);
      fetch(`http://localhost:4000/api/users/onlineStatus`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ids: userIds }),
      })
        .then((response) => response.json())
        .then((statuses) => {
          const statusMap = {};
          (Array.isArray(statuses) ? statuses : [statuses]).forEach(
            ({ id, status }) => {
              statusMap[id] = status;
            }
          );
          setOnlineStatus(statusMap);
        })
        .catch((error) => console.error("Error fetching online status:", error));
    }
  }, [users]);

  useEffect(() => {
    if (socket) {
      socket.on("user status", ({ userId, status }) => {
        setOnlineStatus((prevStatus) => ({
          ...prevStatus,
          [userId]: status,
        }));
      });
    }

    return () => {
      if (socket) {
        socket.off("user status");
      }
    };
  }, [socket]);

  const handleUnmatch = async (userId) => {
    try {
      console.log("handleUnmatch! userId: ", userId);
      const response = await fetch('http://localhost:4000/api/unmatch', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId1: operationUserId, userId2: userId }),
      });

      if (response.ok) {
        dispatch(addNotification({
          id: new Date().getTime().toString(),
          type: 'unmatch',
          message: 'You have unmatched with a user',
          fromUser: userId,
          timestamp: new Date().toISOString(),
        }));
      }
    } catch (error) {
      console.error('Error unmatching user:', error);
    }
  };

  return (
    <div className="flex flex-col m-10 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-2 md:gap-4">
        {users
          .filter((user) => !blockedUsersId.includes(user.id))
          .map((user) => (
            <div key={user.id} className="flex flex-col items-center m-1">
              <Link href={`${link}?userID=${user.id}`}>
                {user && user.profilePic ? (
                  <img
                    src={user.profilePic}
                    alt="Profile Pic"
                    className="h-56 w-56 md:h-64 md:w-64 object-cover rounded"
                  />
                ) : (
                  <div className="h-56 w-56 md:h-64 md:w-64 bg-gray-200 rounded">No Image</div>
                )}
              </Link>
              <div className="flex justify-between items-center mt-2 w-full">
                <div className="flex items-center font-bold">
                  <Link href={`${link}?userID=${user.id}`}>
                    <span>{user.username} ({user.age})</span>
                  </Link>
                  {onlineStatus[user.id] === "online" && (
                    <span className="ml-2 h-3 w-3 bg-green-500 rounded-full"></span>
                  )}
                </div>
                <div className="flex space-x-2">
                  <Heart
                    likeFromUserId={operationUserId}
                    likeToUserId={user.id}
                    alreadyLiked={likedUsersId.includes(user.id)}
                  />
                  <ReportFakeAccount
                    reportedUserId={user.id}
                    alreadyReported={user.fake_account}
                  />
                  <Block
                    blockedFromUserId={operationUserId}
                    blockedToUserId={user.id}
                  />
                </div>
              </div>
              <div className="flex justify-between items-center mt-2 w-full">
                <MatchRatio matchRatio={user.match_ratio} />
                <Geo lat={user.latitude} lon={user.longitude} isRealUser={user.isRealUser} />
              </div>
              <Tag user={user} />
            </div>
          ))}
      </div>
    </div>
  );
}