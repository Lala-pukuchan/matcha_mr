"use client";
import React, { useState, useEffect } from 'react';
import { useUser } from "../../../context/context";
import useWebSocket from "../hooks/useWebSocket";
import useChatRoom from "../hooks/useChatRoom";
import './Chat.css';

function Chat() {
  const [roomID, setRoomID] = useState('');
  const [matches, setMatches] = useState([]);
  const [input, setInput] = useState('');
  const [onlineStatus, setOnlineStatus] = useState({});
  const { user } = useUser();
  const socket = useWebSocket();

  useEffect(() => {
    if (user && user.id) {
      fetch(`http://localhost:4000/api/matches/${user.id}`)
        .then(response => response.json())
        .then(data => {
          setMatches(data);

          const matchIds = data.map(match => match.id);
          fetch(`http://localhost:4000/api/users/onlineStatus`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ ids: matchIds }),
          })
            .then(response => response.json())
            .then(statuses => {
              const statusMap = {};
              (Array.isArray(statuses) ? statuses : [statuses]).forEach(({ id, status }) => {
                statusMap[id] = status;
              });
              setOnlineStatus(statusMap);
            })
            .catch(error => console.error('Error fetching online status:', error));
        })
        .catch(error => console.error('Error fetching matches:', error));
    }
  }, [user]);
  
  useEffect(() => {
    if (socket) {
      socket.on('user status', ({ userId, status }) => {
        setOnlineStatus(prevStatus => ({
          ...prevStatus,
          [userId]: status
        }));
      });
    }

    // クリーンアップ
    return () => {
      if (socket) {
        socket.off('user status');
      }
    };
  }, [socket]);
  const { messages, sendMessage } = useChatRoom(socket, roomID);

  const handleSendMessage = () => {
    const message = { from_user_id: user.id, to_user_id: roomID, message: input, sent_at: new Date().toISOString() };
    sendMessage(message);
    setInput('');
  };

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
          <button onClick={handleSendMessage} className="mt-4 w-60 h-9 rounded bg-pink-400 text-white">
            Send
          </button>
        </div>
      </div>
    </div>
  );
}

export default Chat;
