"use client";
import React, { useState, useEffect } from 'react';
import { useUser } from "../../../context/context";
import useWebSocket from "../hooks/useWebSocket";
import useAuthCheck from "../hooks/useAuthCheck";
import useChatRoom from "../hooks/useChatRoom";
import './Chat.css';

function Chat() {
  useAuthCheck(null, "/login");
  const [roomID, setRoomID] = useState('');
  const [matches, setMatches] = useState([]);
  const [input, setInput] = useState('');
  const [onlineStatus, setOnlineStatus] = useState({});
  const [currentChatPartner, setCurrentChatPartner] = useState(null);
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

    return () => {
      if (socket) {
        socket.off('user status');
      }
    };
  }, [socket]);

  const { messages, sendMessage } = useChatRoom(socket, roomID);
  
  useEffect(() => {
    if (socket && roomID) {
      socket.emit('joinRoom', roomID);
  
      return () => {
        socket.emit('leaveRoom', roomID);
      };
    }
  }, [socket, roomID]);
  
  const handleSendMessage = () => {
    const message = { from_user_id: user.id, to_user_id: roomID, message: input, sent_at: new Date().toISOString() };
    sendMessage(message);
    setInput('');
  };

  const handleUserClick = (match) => {
    setRoomID(match.room_id);
    setCurrentChatPartner(match);
  };

  return (
    <div className="flex flex-col items-center">
      <div className="chat-container bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        
        <div className="chat-prompt">
          Click on a user to start a chat
        </div>

        <div className="user-list-container">
          {matches.map(match => (
            <div
              key={match.id}
              className="user-icon"
              onClick={() => handleUserClick(match)}
            >
              <img
                src={match.profilePic ? match.profilePic : `../../../../server/uploads/icon-1633249_1280.png`}
                alt={match.username}
              />
              <span>{match.username}</span>
              <span className={onlineStatus[match.id] === 'online' ? 'text-green-500' : 'text-gray-500'}>
                {onlineStatus[match.id] === 'online' ? 'Online' : 'Offline'}
              </span>
            </div>
          ))}
        </div>

        {currentChatPartner && (
          <div className="chat-partner-info">
            <img src={currentChatPartner.profilePic ? currentChatPartner.profilePic : `../../../../server/uploads/icon-1633249_1280.png`} alt={currentChatPartner.username} />
            <span>{currentChatPartner.username}</span>
          </div>
        )}

      <div className={`message-input-container ${roomID ? 'active' : ''}`}>
        <div className="message-container mb-4">
          {Array.isArray(messages) && messages.length > 0 ? (
            messages.map((message, index) => (
              <div key={index} className={message.from_user_id === user.id ? 'my-message-wrapper' : 'other-message-wrapper'}>
                <div className={message.from_user_id === user.id ? 'my-message' : 'other-message'}>
                  {message.message}
                </div>
                <div className="timestamp">
                  {new Date(message.sent_at).toLocaleString('ja-JP', { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' })}
                </div>
              </div>
            ))
          ) : (
            <div>No messages to display</div>
          )}
        </div>
        {roomID && (
          <div className="flex items-center justify-between">
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              className="w-full p-2 border rounded mr-4"
              placeholder="Type a message..."
            />
            <button onClick={handleSendMessage} className="mt-4 w-60 h-9 rounded bg-pink-400 text-white">
              Send
            </button>
          </div>
        )}
      </div>
      </div>
    </div>
  );
}

export default Chat;
