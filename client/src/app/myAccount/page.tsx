"use client";
import { useEffect, useState } from "react";
import { useUser } from "../../../context/context";
import UserInfo from "../components/userInfo";
import Link from "next/link";

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
  return (
    <>
      {user ? <UserInfo user={user} /> : <div>Loading...</div>}
      <div className="container mx-auto w-screen flex justify-center">
        <div className="flex flex-col m-10 space-y-4">
          <Link className="text-cyan-400" href="/updateProfile">
            Update your profile?
          </Link>
        </div>
      </div>
    </>
  );
}
