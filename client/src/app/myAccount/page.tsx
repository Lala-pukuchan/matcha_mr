"use client";
import { useEffect, useState } from "react";
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";

export default function myAccount() {
  // get user from context
  const { user, setUser } = useUser();

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

    checkUser();
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }
  return user ? <UserInfo user={user} /> : <div>Loading...</div>;
}
