import { useEffect, useState, useRef } from "react";
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";

function useWebSocket() {
  const [socket, setSocket] = useState(null);
  const { user } = useUser();
  const userRef = useRef(user);
  
  useEffect(() => {
    console.log("coucou test ");
    if (!socket) {
      const newSocket = io('http://localhost:4000', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
    });

    newSocket.on('connect', () => {
      if (userRef.current && userRef.current.id) {
        console.log("WebSocket online account: ", userRef.current.id);
        newSocket.emit('login', userRef.current.id);
      }
    });

    newSocket.on('disconnect', () => {
      console.log('WebSocket disconnected: offline');
      if (userRef.current && userRef.current.id) {
        newSocket.emit('logout', userRef.current.id);
      }
    });
    newSocket.on('user disconnected', () => {
      console.log('@@@@disconnected', userRef.current.id);
    })

    setSocket(newSocket);
  }
    return () => {
      console.log('Cleaning up socket');
      if (socket) {
        socket.close();
      }
    };
  }, [socket]);
/*
  useEffect(() => {
    if (socket && user && user.id) {
      console.log('Updating userRef');
      userRef.current = user;
    }
  }, [socket, user]);
*/
useEffect(() => {
  if (socket) {
    socket.on('user status', ({ userId, status }) => {
      // ここでステータス変更をChatコンポーネントに伝える
      console.log(`User ${userId} is now ${status}`);
    });
  }
}, [socket]);
  return socket;
}

export default useWebSocket;
