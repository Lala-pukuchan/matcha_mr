"use client";
//import { v4 as uuidv4 } from 'uuid';
import { useEffect, useState, useRef, useContext } from "react";
import { io, Socket } from 'socket.io-client';
import { useUser } from "../../../context/context";
import { useDispatch } from 'react-redux';
import { addNotification } from '../store/notificationSlice';

let socketInstance: Socket | null = null;
function getSocketInstance() {
  if (!socketInstance) {
    socketInstance = io(`${process.env.NEXT_PUBLIC_API_URL}`, {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
    });
  }
  return socketInstance;
}
function useWebSocket() {
  const socket = getSocketInstance();
  const { user } = useUser();
  //const { addNotification: addContextNotification } = useContext(NotificationContext); // NotificationContextを使用
  const userRef = useRef(user);
  const dispatch = useDispatch();

  useEffect(() => {
    userRef.current = user;
  }, [user]);

  const disconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);


      socket.off('connect');
      socket.on('connect', () => {
        if (userRef.current && userRef.current.id) {
          console.log("WebSocket connected: ", userRef.current.id);
          socket.emit('login', userRef.current.id);
        }
      });

      socket.off('disconnect');
      socket.on('disconnect', (reason) => {
        console.log('WebSocket disconnected. reason: ', reason);
        if (reason === 'transport close' || reason === 'io client disconnect') {
          console.log("reason is: ", reason);
          setTimeout(() => {
            if (!socket.connected) {
              socket.emit('login');
            }
          }, 5000);
        }
        disconnectTimeoutRef.current = setTimeout(() => {
          if (userRef.current && userRef.current.id) {
            console.log('User is now offline due to disconnect');
            console.log("offline: userRef.current.id: ", userRef.current.id);
            socket.emit('logout', userRef.current.id);
          }
        }, 5000);
      });

      socket.off('reconnect');
      socket.on('reconnect', (attempt) => {
        if (disconnectTimeoutRef.current) {
          clearTimeout(disconnectTimeoutRef.current);
          disconnectTimeoutRef.current = null;
        }
        if (userRef.current && userRef.current.id) {
          console.log("reconnect: userRef.current.id: ", userRef.current.id);
          socket.connect();
          socket.emit('login', userRef.current.id);
        }
      });

      socket.off('message received');
      socket.on('message received', async (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/getUserNameById`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id,
              userId: userRef.current.id,
              type: 'message',
              message: `New message received from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
            console.log("newNotification.id", newNotification.id);
      
            dispatch(addNotification(newNotification));
      
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      socket.off('like received');
      socket.on('like received', async (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/getUserNameById`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id,
              userId: userRef.current.id,
              type: 'like',
              message: `You received a like from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
            console.log("newNotification.id", newNotification.id);
      
            dispatch(addNotification(newNotification));
      
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      socket.off('viewed received');
      socket.on('viewed received', async (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/getUserNameById`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id,
              userId: userRef.current.id,
              type: 'viewed',
              message: `Your profile was viewed by ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));
      
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      socket.off('unlike received');
      socket.on('unlike received', async (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/getUserNameById`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id,
              userId: userRef.current.id,
              type: 'unlike',
              message: `You received a unlike from ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));

          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

      socket.off('match received');
      socket.on('match received', async (notification) => {
        if (userRef.current && userRef.current.id !== notification.from_user_id) {
          try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/getUserNameById`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ userId: notification.from_user_id }),
            });
            const data = await response.json();
            const username = data.username;
      
            const newNotification = {
              id: notification.id,
              userId: userRef.current.id,
              type: 'match',
              message: `You have a new match with ${username}`,
              fromUser: notification.from_user_id,
              timestamp: new Date().toISOString().slice(0, 19).replace('T', ' '),
              checked: false,
            };
      
            dispatch(addNotification(newNotification));
      
          } catch (error) {
            console.error('Error fetching username:', error);
          }
        }
      });

  return socket;
}

export default useWebSocket;