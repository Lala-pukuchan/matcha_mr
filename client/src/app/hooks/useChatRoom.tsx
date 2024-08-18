import { useState, useEffect } from "react";

function useChatRoom(socket, roomID) {
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    if (socket && roomID) {
      console.log('Joining room', roomID);
      socket.emit('joinRoom', roomID);

      fetch(`http://localhost:4000/api/messages/${roomID}`)
        .then(response => response.json())
        .then(data => {
          setMessages(data);
        })
        .catch(error => console.error('Error fetching messages:', error));

      socket.on('chat message', (message) => {
        setMessages(prevMessages => [...prevMessages, message]);
      });


      return () => {
        console.log('Leaving room', roomID);
        socket.emit('leaveRoom', roomID);
      };
    }
  }, [socket, roomID]);

  const sendMessage = (message) => {
    if (socket && roomID) {
      socket.emit('chat message', roomID, message);
    }
  };

  return { messages, sendMessage };
}

export default useChatRoom;
