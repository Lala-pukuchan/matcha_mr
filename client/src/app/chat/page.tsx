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
    console.log("useEffect triggered");
  
    if (!user || !user.id) return;
  
    const newSocket = io('http://localhost:4000', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'], // フォールバックとしてpollingを追加
    });
  
    newSocket.on('connect', () => {
      console.log('WebSocket connected');
      if (userRef.current && userRef.current.id) {
        console.log('Emitting login event');
        newSocket.emit('login', userRef.current.id);
      }
    });
  
    newSocket.on('disconnect', () => {
      console.log('WebSocket disconnected');
      if (userRef.current && userRef.current.id) {
        console.log('Emitting logout event');
        newSocket.emit('logout', userRef.current.id);
      }
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
      console.log('Running cleanup function');
      if (newSocket) {
        console.log('Disconnecting...');
        if (userRef.current && userRef.current.id) {
          newSocket.emit('logout', userRef.current.id);
        }
        newSocket.close();
      }
    };
  }, [user?.id]); // 依存配列をuser?.idに変更

  useEffect(() => {
    if (user && user.id) {
      console.log('Fetching matches');
      fetch(`http://localhost:4000/matches/${user.id}`)
        .then(response => response.json())
        .then(data => setMatches(data))
        .catch(error => console.error('Error fetching matches:', error));
    }
  }, [user?.id]); // 依存配列をuser?.idに変更

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
      fetch(`http://localhost:4000/messages/${roomID}`)
        .then(response => response.json())
        .then(data => {
          console.log("Fetched messages: ", data);
          setMessages(data);
        })
        .catch(error => console.error('Error fetching messages:', error));
    }
  }, [roomID, socket]);

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
                src={match.profilePic ? match.profilePic : `path_to_default_picture/default.jpg`} // プロフィール写真のパスを適切に変更してください
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
