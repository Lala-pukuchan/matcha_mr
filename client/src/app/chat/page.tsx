"use client";
import React, { useState, useEffect } from 'react';
import { io } from 'socket.io-client';
import { useUser } from "../../../context/context";

function Chat() {
  const [socket, setSocket] = useState(null);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [roomID, setRoomID] = useState('');
  const [matches, setMatches] = useState([]);
  const { user } = useUser();

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

    return () => {
      if (newSocket) {
        console.log('Disconnecting...');
        newSocket.close();
      }
    };
  }, []);

  useEffect(() => {
    console.log("user.id: ", user);
    if (user && user.id) {
      fetch(`http://localhost:4000/matches/${user.id}`)
        .then(response => response.json())
        .then(data => setMatches(data))
        .catch(error => console.error('Error fetching matches:', error));
    }
  }, [user]);

  const sendMessage = () => {
    if (socket && socket.connected && roomID) {
      const message = { to: roomID, text: input, sent_at: new Date().toISOString() };
      socket.emit('chat message', roomID, message);
      setMessages(prevMessages => [...prevMessages, message]);
      setInput('');
    } else {
      console.log('Socket is not connected or no room selected.');
    }
  };

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
          <li key={index}>{`${message.text} (Sent at: ${new Date(message.sent_at).toLocaleString()})`}</li>
        ))}
      </ul>
      <select
        onChange={(event) => setRoomID(event.target.value)}
        value={roomID}
      >
        <option value="">Select a match</option>
        {matches.map(match => (
          <option key={match.id} value={match.room_id}>{match.username}</option>
        ))}
      </select>
      <input type="text" value={input} onChange={(e) => setInput(e.target.value)} />
      <button onClick={sendMessage}>Send</button>
    </div>
  );
}

export default Chat;
