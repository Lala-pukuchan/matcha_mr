"use client";
import { useEffect, useState } from "react";
import UserInfo from "../components/userInfo";

export default function users() {
  const [user, setUser] = useState([]);
  useEffect(() => {
    const queryParams = new URLSearchParams(window.location.search);

    if (queryParams.get("userID") !== null) {
      const userId = queryParams.get("userID");
      const userJson = JSON.stringify({ userId: userId });
      const fetchUser = async () => {
        try {
          const response = await fetch(
            `${process.env.NEXT_PUBLIC_API_URL}/api/user`,
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
            setUser(data);
            console.log("data", data);
          } else {
            setUser([]);
          }
        } catch (e) {
          setUser([]);
          console.error(e);
        }
      };
      fetchUser();
    }
  }, []);

  return (
    <div>
      <h1>User Page</h1>
      <UserInfo user={user} />
    </div>
  );
}
