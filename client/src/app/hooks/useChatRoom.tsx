import { useState, useEffect } from "react";

function useChatRoom(socket: any, roomID: string) {
  const [messages, setMessages] = useState<Array<{ from_user_id: string; message: string; sent_at: string }>>([]);

  useEffect(() => {
    if (socket && roomID) {
      socket.emit('joinRoom', roomID);

      fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/messages/${roomID}`)
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

      socket.on('chat message', (message: { from_user_id: string; message: string; sent_at: string }) => {
        setMessages(prevMessages => [...prevMessages, message]);
      });

      return () => {
        socket.emit('leaveRoom', roomID);
      };
    }
  }, [socket, roomID]);

  const sendMessage = (message: { from_user_id: string; message: string }) => {
    if (socket && roomID) {
      if (message.message.trim() === '') {
        console.error('Message cannot be empty.');
        return;
      }

      socket.emit('chat message', roomID, message);
    }
  };

  return { messages, sendMessage };
}

export default useChatRoom;
