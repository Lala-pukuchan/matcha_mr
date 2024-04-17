"use client";
import React, { useState, useEffect } from 'react';
import { io } from 'socket.io-client';

function Chat() {
  const [socket, setSocket] = useState(null);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [roomID, setRoomID] = useState('');


  // Function to connect to the WebSocket server
  const connectSocket = () => {
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

    return newSocket;
  };

  const sendMessage = () => {
    if (!socket || !socket.connected) {
      console.log('Socket is not connected, attempting to connect...');
      const newSocket = connectSocket();
      newSocket.on('connect', () => {
        newSocket.emit('chat message', roomID, input);
        setInput('');
      });
    } else {
      socket.emit('chat message', roomID, input);
      setInput('');
    }
  };

  useEffect(() => {
    return () => {
      if (socket) {
        console.log('Disconnecting...');
        socket.close();
      }
    };
  }, [socket]);

  return (
    <div>
      <ul>
        {messages.map((message, index) => (
          <li key={index}>{message}</li>
        ))}
      </ul>
      <select
        onChange={(event) => {
          const newRoomID = event.target.value;
          setRoomID(newRoomID);
          if (socket) {
            socket.emit('joinRoom', newRoomID);
          }
          setMessages([]);
        }}
        value={roomID}
      >
        <option value="">---</option>
        <option value="1">Room1</option>
        <option value="2">Room2</option>
      </select>
      <input type="text" value={input} onChange={(e) => setInput(e.target.value)} />
      <button onClick={sendMessage}>Send</button>
    </div>
  );
}

export default Chat;
