"use client";
import { useEffect } from "react";

export default function Home() {
  async function getUserInfo() {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_API_URL}/api/userinfo`,
      {
        method: "GET",
        credentials: "include",
      }
    );
    if (response.status === 200) {
      const data = await response.json();
      console.log("message", data);
    } else {
      const data = await response.json();
      console.log("message", data.message);
    }
  }

  useEffect(() => {
    getUserInfo();
  });

  return <div className="flex justify-center">HOME</div>;
}
