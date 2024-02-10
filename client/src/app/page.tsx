"use client";
import { useState, useEffect } from "react";
import { useUser } from "../../context/context";
import UsersList from "./components/userList";

export default function Home() {
  const user = useUser();
  const [users, setUserList] = useState([]);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users`
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
    fetchUsers();
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
      <div className="container mx-auto w-screen flex justify-center">
        <UsersList users={users} />
      </div>
    </>
  );
}
