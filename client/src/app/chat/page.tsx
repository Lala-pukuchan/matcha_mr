"use client";
import React, { useState, useEffect, useRef } from 'react';
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";
import './Chat.css';

function Chat() {
  const [socket, setSocket] = useState(null);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [roomID, setRoomID] = useState('');
  const [matches, setMatches] = useState([]);
  const [onlineStatus, setOnlineStatus] = useState({});
  const { user } = useUser();
  const userRef = useRef(user);

  useEffect(() => {
    userRef.current = user;
  }, [user]);

  useEffect(() => {
    if (!user || !user.id) return; // userがnullまたはidがない場合は何もしない

    const newSocket = io('http://localhost:4000', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
    });

    newSocket.on('connect', () => {
      console.log('WebSocket connected for chat');
    });

    newSocket.on('disconnect', () => {
      console.log('WebSocket disconnected from chat');
    });

    newSocket.on('chat message', (message) => {
      console.log('Received chat message:', message);
      setMessages(prevMessages => [...prevMessages, message]);
    });

    newSocket.on('user status', ({ userId, status }) => {
      console.log(`User status updated: ${userId} is ${status}`);
      setOnlineStatus(prevStatus => ({
        ...prevStatus,
        [userId]: status
      }));
    });

    setSocket(newSocket);

    return () => {
      if (newSocket) {
        newSocket.close();
      }
    };
  }, [user]);

  useEffect(() => {
    if (user && user.id) {
      console.log('Fetching matches');
      fetch(`http://localhost:4000/api/matches/${user.id}`)
        .then(response => response.json())
        .then(data => setMatches(data))
        .catch(error => console.error('Error fetching matches:', error));
    }
  }, [user]);

  const sendMessage = () => {
    if (socket && socket.connected && roomID) {
      const message = { from_user_id: user.id, to_user_id: roomID, message: input, sent_at: new Date().toISOString() };
      console.log('Emitting chat message event');
      socket.emit('chat message', roomID, message);
      setInput('');
    } else {
      console.log('Socket is not connected or no room selected.');
    }
  };

  useEffect(() => {
    if (socket && roomID) {
      console.log('Joining room', roomID);
      socket.emit('joinRoom', roomID);
      fetch(`http://localhost:4000/api/messages/${roomID}`)
        .then(response => response.json())
        .then(data => {
          console.log("Fetched messages: ", data);
          setMessages(data);
        })
        .catch(error => console.error('Error fetching messages:', error));
    }
  }, [roomID, socket]);

  // userがnullの場合は何も表示しない
  if (!user || !user.id) {
    return <div>Loading...</div>;
  }

  return (
    <div className="flex flex-col items-center">
      <div className="w-full max-w-5xl bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <div className="flex justify-center mb-6">
          {matches.map(match => (
            <div
              key={match.id}
              className="flex flex-col items-center mx-4 cursor-pointer"
              onClick={() => setRoomID(match.room_id)}
            >
              <img
                src={match.profilePic ? match.profilePic : `../../../../server/uploads/icon-1633249_1280.png`}
                alt={match.username}
                className="profile-picture"
              />
              <span>{match.username}</span>
              <span className={onlineStatus[match.id] === 'online' ? 'text-green-500' : 'text-gray-500'}>
                {onlineStatus[match.id] === 'online' ? 'Online' : 'Offline'}
              </span>
            </div>
          ))}
        </div>
        <div className="message-container mb-4">
          {messages.map((message, index) => (
            <div key={index} className={message.from_user_id === user.id ? 'my-message-wrapper' : 'other-message-wrapper'}>
              <div className={message.from_user_id === user.id ? 'my-message' : 'other-message'}>
                {message.message}
              </div>
              <div className="timestamp">
                {new Date(message.sent_at).toLocaleString('ja-JP', { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' })}
              </div>
            </div>
          ))}
        </div>
        <div className="flex items-center justify-between">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            className="w-full p-2 border rounded mr-4"
          />
          <button onClick={sendMessage} className="mt-4 w-60 h-9 rounded bg-pink-400 text-white">
            Send
          </button>
        </div>
      </div>
    </div>
  );
}

export default Chat;
