"use client";

import { useState, useEffect } from "react";
import { io } from 'socket.io-client';
import useWebSocket from "../hooks/useWebSocket";

export default function Logout() {
  const [message, setMessage] = useState("");
  const socket = useWebSocket(); 

  useEffect(() => {
    fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/logout`, {
      method: "POST",
      credentials: 'include',
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.message === "success") {
          console.log('Logout successful');
          if (socket && socket.connected) {
            socket.emit('logout', data.userId);
          }
          window.location.href = "/login";
        } else {
          console.log(data);
          setMessage("Error logging out");
        }
      });
  }, [socket]); // socketが依存に追加されている

  return <div>{message}</div>;
}