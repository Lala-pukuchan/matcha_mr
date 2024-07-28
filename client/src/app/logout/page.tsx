"use client";

import { useState, useEffect } from "react";

export default function Logout() {
  const [message, setMessage] = useState("");
  useEffect(() => {
    fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/logout`, {
      method: "POST",
      credentials: 'include',
    })
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        if (data.message === "success") {
          window.location.href = "/login";
          
        } else {
          console.log(data);
          setMessage("Error logging out");
        }
      });
  }, []);
  return <div>{message}</div>;
}
