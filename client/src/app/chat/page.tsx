"use client";
import React, { useState, useEffect, useContext } from 'react';
import { useUser } from '../../../context/context';
//import { NotificationContext } from '../../../context/notification';
import useWebSocket from '../hooks/useWebSocket';
import useAuthCheck from '../hooks/useAuthCheck';
import useChatRoom from '../hooks/useChatRoom';
import './Chat.css';



function Chat() {
  useAuthCheck("", "/login");
  const [roomID, setRoomID] = useState('');
  const [matches, setMatches] = useState<Array<{ id: string; room_id: string; profilePic?: string; username: string }>>([]);
  const [input, setInput] = useState('');
  const [onlineStatus, setOnlineStatus] = useState<{ [key: string]: string }>({});
  const [currentChatPartner, setCurrentChatPartner] = useState<{ room_id: string; profilePic?: string; username: string } | null>(null);
  const { user } = useUser();
  const socket = useWebSocket();
  // const { clearNotifications } = useContext(NotificationContext);

  // 最初にマッチとオンラインステータスを取得する処理
  useEffect(() => {
    // clearNotifications && clearNotifications();
    
    if (user && user.id) {
      fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/matches/${user.id}`)
        .then(response => response.json())
        .then(data => {
          // 前回のmatchesと異なる場合にのみ更新
          if (JSON.stringify(matches) !== JSON.stringify(data)) {
            setMatches(data);
          }

          const matchIds = data.map((match: { id: number }) => match.id);
          if (matchIds.length > 0) {
            fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users/onlineStatus`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ ids: matchIds }),
            })
              .then(response => response.json())
              .then(statuses => {
                const statusMap: { [key: string]: string } = {};
                (Array.isArray(statuses) ? statuses : [statuses]).forEach(({ id, status }) => {
                  statusMap[id] = status;
                });
                
                // 状態が変わった場合のみ更新を行う
                setOnlineStatus((prevStatus: { [key: string]: string }) => {
                  const isStatusChanged = Object.keys(statusMap).some(
                    key => statusMap[key] !== prevStatus[key]
                  );
                  return isStatusChanged ? statusMap : prevStatus;
                });
              })
              .catch(error => console.error('Error fetching online status:', error));
          }
        })
        .catch(error => console.error('Error fetching matches:', error));
    }
  }, [user]);

  // ソケットからのオンラインステータス更新をリッスンする処理
  useEffect(() => {
    if (socket) {
      socket.on('user status', ({ userId, status }) => {
        console.log("handleUserStatus called from socket:", userId, status);
        setOnlineStatus(prevStatus => ({
          ...prevStatus,
          [userId]: status,
        }));
      });
  
      const handleBlocked = ({ from_user_id }: { from_user_id: string }) => {
        setMatches(prevMatches => prevMatches.filter(match => match.id !== from_user_id));
        if (currentChatPartner && currentChatPartner.room_id === from_user_id) {
          setCurrentChatPartner(null);
          setRoomID('');
          setInput('');
        }
      };
      socket.on('blocked', handleBlocked);
  
      return () => { 
        if (socket) {
          socket.off('user status');
          socket.off('blocked', handleBlocked);
        }
      };
    }
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
    if (input.trim() !== '') {
      const message = { from_user_id: user.id, to_user_id: roomID, message: input, sent_at: new Date().toISOString() };
      sendMessage(message);
      setInput('');
    }
  };

  const handleUserClick = (match: { room_id: string; profilePic?: string; username: string }) => {
    setRoomID(match.room_id);
    setCurrentChatPartner(match);
  };
  useEffect(() => {
    const messageContainer = document.querySelector('.message-container');
    if (messageContainer) {
      messageContainer.scrollTop = messageContainer.scrollHeight;
    }
  }, [messages]);

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