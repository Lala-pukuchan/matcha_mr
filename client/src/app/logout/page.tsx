"use client";

import { useState, useEffect } from "react";
import { io } from 'socket.io-client';

export default function Logout() {
  const [message, setMessage] = useState("");
  const [socket, setSocket] = useState(null);

  useEffect(() => {
    const newSocket = io('http://localhost:4000', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
    });

    newSocket.on('connect', () => {
      console.log('WebSocket connected for logout');
    });

    newSocket.on('disconnect', () => {
      console.log('WebSocket disconnected from logout');
    });

    setSocket(newSocket);

    fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/logout`, {
      method: "POST",
      credentials: 'include',
    })
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        if (data.message === "success") {
          console.log('Logout successful');
          if (socket && socket.connected) {
            socket.emit('logout', data.userId); // サーバーにユーザーのログアウト状態を通知
          }
          window.location.href = "/login";
        } else {
          console.log(data);
          setMessage("Error logging out");
        }
      });

    return () => {
      if (newSocket) {
        newSocket.close();
      }
    };
  }, []);

  return <div>{message}</div>;
}
