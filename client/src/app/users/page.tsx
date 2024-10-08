"use client";
import { useEffect, useState } from "react";
import UserInfo from "../components/userInfo";
import { useUser } from "../../../context/context";

export default function users() {
  // displaid user information
  const [displayedUser, setDisplayedUser] = useState([]);
  // operating user information
  const { user, setUser } = useUser();
  // set loading
  const [loading, setLoading] = useState(true);

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
            setDisplayedUser([]);
          }
        } catch (e) {
          setDisplayedUser([]);
          console.error(e);
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
            } else {
              console.error("updating viewed is failed");
            }
          } catch (e) {
            console.error(e);
          }
        }
      };

      fetchUser();
      updateViewed();
    }
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <div>
        <UserInfo user={displayedUser} />
      </div>
    </>
  );
}
