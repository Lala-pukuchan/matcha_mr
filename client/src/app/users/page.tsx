"use client";
import { useEffect, useState } from "react";
import UserInfo from "../components/userInfo";
import { useUser } from "../../../context/context";
import useWebSocket from "../hooks/useWebSocket";
import { useDispatch } from "react-redux";

export default function Users() {
  const socket = useWebSocket();
  const dispatch = useDispatch();
  // displaid user information
  const [displayedUser, setDisplayedUser] = useState<User | null>(null);
  // operating user information
  const { user, setUser } = useUser();
  // set loading
  const [loading, setLoading] = useState(true);
  const [matched, setMatched] = useState(false);
  const [likedByUser, setLikedByUser] = useState(false);
  const [likedByOther, setLikedByOther] = useState(false);

  interface User {
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
    match_ratio: number;
    latitude: number;
    longitude: number;
    distance: number;
    common_tags_count: number;
    fake_account: boolean;
    isRealUser: boolean;
    gender: string;
    preference: string;
    biography: string;
    liked: string;
    matched: string;
  }

  useEffect(() => {
    let viewUserId = "";
    const queryParams = new URLSearchParams(window.location.search);

    // get displayed user
    if (queryParams.get("userID") !== null) {
      const userId = queryParams.get("userID");
      const userJson = JSON.stringify({ userId: userId });

      // get userinfo
      const fetchUser = async () => {
        try {
          const response = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/users/userById`,
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: userJson,
            }
          );

          if (response.ok) {
            const data = await response.json();
            setDisplayedUser(data);
          } else {
            setDisplayedUser(null);
          }
        } catch (e) {
          setDisplayedUser(null);
          console.error(e);
        }
      };

      //get if user is matched
      const checkMatched = async () => {
        if (user) {
        const matchJson = JSON.stringify({ from: user.id, to: userId });
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/checkMatched`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: matchJson,
        });
        const data = await response.json();
        setMatched(data.matched);
      }
      };

      //get if user is liked
      const checkLiked = async () => {
        if (user) {
          const likeStatusJson = JSON.stringify({ from: user.id, to: userId });
          const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/checkLikedStatus`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: likeStatusJson,
          });
          if (response.ok) {
            const data = await response.json();
            setLikedByUser(data.likedByUser);
            setLikedByOther(data.likedByOther);
          } else {
            setLikedByUser(false);
            setLikedByOther(false);
          }
        }
      };

      // update viewed
      const updateViewed = async () => {
        await new Promise((resolve) => setTimeout(resolve, 2000));
        setLoading(false);
        if (user) {
          try {
            const viewJson = JSON.stringify({ from: user.id, to: userId });
            const response = await fetch(
              `${process.env.NEXT_PUBLIC_API_URL}/api/users/viewed`,
              {
                method: "POST",
                headers: {
                  "Content-Type": "application/json",
                },
                body: viewJson,
              }
            );

            if (response.ok) {
              // WebSocketを通じて通知を送信
              if (socket) {
                socket.emit('viewed', { fromUserId: user.id, toUserId: userId });
              } else {
                console.error("Socket is null");
              }
            } else {
              console.error("updating viewed is failed");
            }
          } catch (e) {
            console.error(e);
          }
        }
      };

      fetchUser();
      checkMatched();
      checkLiked();

      // socketがnullでないことを確認してからupdateViewedを呼び出す
      const interval = setInterval(() => {
        if (socket) {
          updateViewed();
          clearInterval(interval);
        }
      }, 100);
    }
  }, [user, socket]); // userとsocketの変更を監視

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="container mx-auto flex justify-center px-4 md:px-0">
      <div className="flex flex-col space-y-6 max-w-md md:max-w-lg">
      {displayedUser ? (
        <UserInfo user={displayedUser} />
      ) : (
        <p>user not found</p>
      )}
        {matched && (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Match Status</p>
            <p>You are matched with this user🔥</p>
          </div>
        )}
        {!matched && likedByUser && (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Like Status</p>
            <p>You like this user💌</p>
          </div>
        )}
        {!matched && likedByOther && (
          <div className="grid gap-4 grid-cols-2 mx-auto w-full">
            <p className="font-bold">Like Status</p>
            <p>This user likes you❤️</p>
          </div>
        )}
      </div>
    </div>
  );
}