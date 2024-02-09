"use client";
import { useEffect } from "react";
import { useUser } from "../../context/context";

export default function Home() {
  // if user is not logged in, redirect to login page
  const user = useUser();
  useEffect(() => {
    if (!user) {
      window.location.href = "/login";
    }
  }, [user]);

  return (
    <>
      <div className="flex justify-center">
        <div className="text-pink-400">
          {user ? (
            <p>You have already loggedin, {user.username}</p>
          ) : (
            <p>Please log in</p>
          )}
        </div>
      </div>
      <div className="flex justify-center">
        <div className="text-gray-500">HOME</div>
      </div>
    </>
  );
}
