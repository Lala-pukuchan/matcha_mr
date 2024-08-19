import { useState, useEffect } from "react";

function useChatRoom(socket, roomID) {
  const [messages, setMessages] = useState([]);
  const [notifications, setNotifications] = useState([]);

  useEffect(() => {
    if (socket && roomID) {
      socket.emit('joinRoom', roomID);

      fetch(`http://localhost:4000/api/messages/${roomID}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          setMessages(data);
        })
        .catch(error => console.error('Error fetching messages:', error));

      socket.on('chat message', (message) => {
        setMessages(prevMessages => [...prevMessages, message]);
      });

      socket.on('message received', (notification) => {
        console.log('Message received from user', notification.from_user_id);
        setNotifications(prevNotifications => [
          ...prevNotifications,
          `Message received from user ${notification.from_user_id}`
        ]);
      });

      return () => {
        console.log('Leaving room', roomID);
        socket.emit('leaveRoom', roomID);
        socket.off('message received');
      };
    }
  }, [socket, roomID]);

  const sendMessage = (message) => {
    if (socket && roomID) {
      if (message.message.trim() === '') {
        console.error('Message cannot be empty.');
        return;
      }

      socket.emit('chat message', roomID, message);
    }
  };

  return { messages, sendMessage, notifications };
}

export default useChatRoom;
