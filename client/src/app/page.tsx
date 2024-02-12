"use client";
import { useState, useEffect } from "react";
import { useUser } from "../../context/context";
import UsersList from "./components/userList";

export default function Home() {
  // get user from context
  const { user, setUser } = useUser();
  // set user list
  const [users, setUserList] = useState([]);
  // set loading
  const [loading, setLoading] = useState(true);

  // check user
  useEffect(() => {
    const checkUser = async () => {
      await new Promise((resolve) => setTimeout(resolve, 2000));
      setLoading(false);
      if (!user) {
        window.location.href = "/login";
      }
    };
    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users`
        );
        if (response.ok) {
          const data = await response.json();
          console.log("user", user);
          console.log("user.id", user.id);
          console.log("data", data);
          setUserList(data.filter((d) => d.id !== user.id));
        } else {
          setUserList([]);
        }
      } catch (e) {
        setUserList([]);
        console.error(e);
      }
    };

    checkUser();
    fetchUsers();
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

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
      <div className="container mx-auto w-screen flex justify-center">
        <UsersList users={users} />
      </div>
    </>
  );
}
