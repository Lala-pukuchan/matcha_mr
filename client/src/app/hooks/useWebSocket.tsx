"use client";
import { v4 as uuidv4 } from 'uuid';
import { useEffect, useState, useRef, useContext } from "react";
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";
import { NotificationContext } from "../../../context/notification"; // NotificationContextをインポート
import { useDispatch } from 'react-redux';
import { addNotification } from '../store/notificationSlice';


function useWebSocket() {
  const [socket, setSocket] = useState(null);
  const { user } = useUser();
  //const { addNotification: addContextNotification } = useContext(NotificationContext); // NotificationContextを使用
  const userRef = useRef(user);
  const dispatch = useDispatch();

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

      newSocket.on('disconnect', (reason) => {
        console.log('WebSocket disconnected. reason: ', reason);
        if (reason === 'transport close' || reason === 'io client disconnect') {
          console.log("reason is: ", reason);
          setTimeout(() => {
            if (!newSocket.connected) {
              newSocket.emit('login');
            }
          }, 5000);
        }
        disconnectTimeoutRef.current = setTimeout(() => {
          if (userRef.current && userRef.current.id) {
            console.log('User is now offline due to disconnect');
            console.log("offline: userRef.current.id: ", userRef.current.id);
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
          console.log("reconnect: userRef.current.id: ", userRef.current.id);
          newSocket.connect();
          newSocket.emit('login', userRef.current.id);
        }
      });

      newSocket.on('message received', async (notification) => {
        console.log('Message received from user', notification.from_user_id);
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch('http://localhost:4000/api/users/getUserNameById', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id || uuidv4(),
              userId: userRef.current.id,
              type: 'message',
              message: `New message received from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));
      
            // データベースに通知を保存
            await fetch('http://localhost:4000/api/notifications/save', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(newNotification),
            });
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      newSocket.on('like received', async (notification) => {
        console.log("like received:::::::::::", notification);
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch('http://localhost:4000/api/users/getUserNameById', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id || uuidv4(),
              userId: userRef.current.id,
              type: 'like',
              message: `You received a like from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));
      
            // データベースに通知を保存
            await fetch('http://localhost:4000/api/notifications/save', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(newNotification),
            });
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      newSocket.on('unlike received', async (notification) => {
        console.log("unlike received:::::::::::", notification);
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch('http://localhost:4000/api/users/getUserNameById', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id || uuidv4(),
              userId: userRef.current.id,
              type: 'unlike',
              message: `You received a unlike from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));
      
            // データベースに通知を保存
            await fetch('http://localhost:4000/api/notifications/save', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(newNotification),
            });
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      newSocket.on('match received', (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          dispatch(addNotification({
            id: notification.id,
            type: 'match',
            message: 'You have a new match',
            fromUser: notification.from_user_id,
            timestamp: new Date().toISOString(),
          }));
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
  }, [socket, dispatch]);

  return socket;
}

export default useWebSocket;