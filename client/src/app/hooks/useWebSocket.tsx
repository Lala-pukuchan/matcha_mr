import { useEffect, useState, useRef } from "react";
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";

function useWebSocket() {
  const [socket, setSocket] = useState(null);
  const { user } = useUser();
  const userRef = useRef(user);

  useEffect(() => {
    userRef.current = user;
  }, [user]);

  const disconnectTimeoutRef = useRef(null);

  useEffect(() => {
    if (!socket) {
      const newSocket = io('http://localhost:4000', {
        withCredentials: true,
        reconnectionAttempts: 5,
        reconnectionDelay: 5000,
        transports: ['websocket', 'polling'],
      });

      newSocket.on('connect', () => {
        if (userRef.current && userRef.current.id) {
          console.log("WebSocket connected: ", userRef.current.id);
          newSocket.emit('login', userRef.current.id);
        }
      });

      newSocket.on('disconnect', () => {
        console.log('WebSocket disconnected');
        disconnectTimeoutRef.current = setTimeout(() => {
          if (userRef.current && userRef.current.id) {
            console.log('User is now offline due to disconnect');
            newSocket.emit('logout', userRef.current.id);
          }
        }, 5000);
      });

      newSocket.on('reconnect', (attempt) => {
        console.log('WebSocket reconnected: ', attempt);
        if (disconnectTimeoutRef.current) {
          clearTimeout(disconnectTimeoutRef.current);
          disconnectTimeoutRef.current = null;
        }
        if (userRef.current && userRef.current.id) {
          newSocket.emit('login', userRef.current.id);
        }
      });

      setSocket(newSocket);
    }

    return () => {
      console.log('Cleaning up socket');
      if (socket) {
        socket.close();
      }
    };
  }, [socket]);

  useEffect(() => {
    if (socket) {
      socket.on('user status', ({ userId, status }) => {
        console.log(`User ${userId} is now ${status}`);
      });
    }

    return () => {
      if (socket) {
        socket.off('user status');
      }
    };
  }, [socket]);

  return socket;
}

export default useWebSocket;
