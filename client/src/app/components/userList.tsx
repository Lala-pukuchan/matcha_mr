import Link from "next/link";
import Heart from "./heart";
import Geo from "./geo";
import MatchRatio from "./matchRatio";
import ReportFakeAccount from "./reportFakeAccount";
import Block from "./block";
import { useState, useEffect } from "react";
import { useDispatch } from 'react-redux';
import { addNotification } from '../store/notificationSlice';
import useWebSocket from '../hooks/useWebSocket';

export default function UsersList({
  users,
  operationUserId,
  likedUsersId,
  blockedUsersId,
  link,
}: {
  users: Array<{ id: string; status: string; tagIds?: string[]; profilePic?: string; username: string; age: number; match_ratio: number; latitude: number; longitude: number; isRealUser: boolean; fake_account: boolean }>;
  operationUserId: string;
  likedUsersId: string[];
  blockedUsersId: string[];
  link: string;
}) {
  const [onlineStatus, setOnlineStatus] = useState<Record<string, string>>({});
  const [currentPage, setCurrentPage] = useState(1);
  const [displayedUsers, setDisplayedUsers] = useState<Array<{ id: string; status: string; tagIds?: string[]; profilePic?: string; username: string; age: number; match_ratio: number; latitude: number; longitude: number; isRealUser: boolean; fake_account: boolean }>>([]);
  const [userTags, setUserTags] = useState<Record<string, string[]>>({});
  const [loadingTags, setLoadingTags] = useState(true);
  const usersPerPage = 8;
  const dispatch = useDispatch();
  const socket = useWebSocket();

  useEffect(() => {
    const startIndex = (currentPage - 1) * usersPerPage;
    const endIndex = startIndex + usersPerPage;
    const currentUsers = users.slice(startIndex, endIndex);
    setDisplayedUsers(currentUsers);

    const initialStatus = currentUsers.reduce((acc: Record<string, string>, user) => {
      acc[user.id] = user.status;
      return acc;
    }, {});
    setOnlineStatus(initialStatus);

    const fetchTagsForUsers = async () => {
      try {
        const tagsResponse = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/tags`);
        const tagsData = await tagsResponse.json();
        const tagsMap = tagsData.reduce((acc: Record<string, string>, tag: { id: string; name: string }) => {
          acc[tag.id] = tag.name;
          return acc;
        }, {});

        const userTagsMap: Record<string, string[]> = {};
        for (const user of currentUsers) {
          const userTagIds = user.tagIds || [];
          userTagsMap[user.id] = userTagIds.map(tagId => tagsMap[tagId]);
        }
        setUserTags(userTagsMap);
        setLoadingTags(false);
      } catch (error) {
        console.error("Error fetching tags:", error);
        setLoadingTags(false);
      }
    };

    fetchTagsForUsers();
  }, [users, currentPage]);

  useEffect(() => {
    if (socket) {
      const handleUserStatus = ({ userId, status }: { userId: string; status: string })  => {
        setOnlineStatus((prevStatus) => ({
          ...prevStatus,
          [userId]: status,
        }));
      };
      socket.off("user status", handleUserStatus);
      socket.on("user status", handleUserStatus);
      return () => {
        socket.off("user status", handleUserStatus);
      };
    }
  }, [socket]);

  const handleUnmatch = async (userId: string) => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/unmatch`, {
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

  const handleNextPage = () => {
    if (currentPage * usersPerPage < users.length) {
      setCurrentPage((prevPage) => prevPage + 1);
    }
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) {
      setCurrentPage((prevPage) => prevPage - 1);
    }
  };

  if (loadingTags) {
    return <div>Loading ...</div>;
  }

  return (
    <div className="flex flex-col m-10 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-2 md:gap-4">
        {displayedUsers
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
                  {(onlineStatus[user.id] || user.status) === "online" && (
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
                    reportedUserId={Number(user.id)}
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
              <div className="flex flex-wrap gap-2 mt-2">
                {userTags[user.id] && userTags[user.id].map((tag, index) => (
                  <span key={`${user.id}-${index}`} className="bg-gray-200 px-2 py-1 rounded text-sm">
                    #{tag}
                  </span>
                ))}
              </div>
            </div>
          ))}
      </div>
      <div className="flex justify-between mt-4">
        <button
          onClick={handlePreviousPage}
          disabled={currentPage === 1}
          className="px-4 py-2 bg-blue-500 text-white rounded disabled:opacity-50"
        >
          Previous
        </button>
        <button
          onClick={handleNextPage}
          disabled={currentPage * usersPerPage >= users.length}
          className="px-4 py-2 bg-blue-500 text-white rounded disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>
  );
}