"use client";
import React, { useState, useEffect } from 'react';
import { io } from 'socket.io-client';

function Chat() {
  const [socket, setSocket] = useState(null);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [roomID, setRoomID] = useState('');

  // Connect to the WebSocket server immediately when the component mounts
  useEffect(() => {
    const newSocket = io('http://localhost:4000/', {
      withCredentials: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 5000,
      transports: ['websocket', 'polling'],
      extraHeaders: {'Access-Control-Allow-Origin': "http://localhost:4000/"}
    });

    newSocket.on('chat message', (message) => {
      setMessages(prevMessages => [...prevMessages, message]);
    });

    newSocket.on('connect', () => {
      console.log('WebSocket connected');
    });

    setSocket(newSocket);

    // Clean up the socket when the component unmounts
    return () => {
      if (newSocket) {
        console.log('Disconnecting...');
        newSocket.close();
      }
    };
  }, []);

  // Handle sending messages
  const sendMessage = () => {
    if (socket && socket.connected) {
      socket.emit('chat message', roomID, input);
      setInput('');
    } else {
      console.log('Socket is not connected.');
    }
  };

  // Handle changing rooms
  useEffect(() => {
    if (socket && roomID) {
      socket.emit('joinRoom', roomID);
      setMessages([]);
    }
  }, [roomID, socket]);

  return (
    <div>
      <ul>
        {messages.map((message, index) => (
          <li key={index}>{message}</li>
        ))}
      </ul>
      <select
        onChange={(event) => setRoomID(event.target.value)}
        value={roomID}
      >
        <option value="">Select a room</option>
        <option value="1">Room1</option>
        <option value="2">Room2</option>
      </select>
      <input type="text" value={input} onChange={(e) => setInput(e.target.value)} />
      <button onClick={sendMessage}>Send</button>
    </div>
  );
}

export default Chat;
