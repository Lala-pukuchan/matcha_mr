import React, { useState, useEffect } from "react";
import useWebSocket from "../hooks/useWebSocket";

const Block = ({ blockedFromUserId, blockedToUserId, alreadyBlocked }: { blockedFromUserId: string; blockedToUserId: string; alreadyBlocked: boolean }) => {
  const [isClicked, setIsClicked] = useState(alreadyBlocked);
  const [errorMessage, setErrorMessage] = useState("");
  const socket = useWebSocket();

  useEffect(() => {
    setIsClicked(alreadyBlocked);
  }, [alreadyBlocked]);

  const block = () => {
    // update state
    setIsClicked(!isClicked);

    // update block
    let url = `${process.env.NEXT_PUBLIC_API_URL}/api/users/blocked`;
    let blocked = true;
    if (isClicked) {
      blocked = false;
    }
    async function updateBlock() {
      try {
        const blockJson = JSON.stringify({
          from: blockedFromUserId,
          to: blockedToUserId,
          blocked: blocked,
        });
        const response = await fetch(url, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: blockJson,
        });
        console.log("response: ", response);
        if (response.ok) {
          const responseData = await response.json();
          socket.emit('block', { fromUserId: blockedFromUserId, toUserId: blockedToUserId });
          console.log("responseData: ", responseData);
        } else {
          console.error("updating blockd is failed");
        }
      } catch (e) {
        console.error(e);
      }
    }
    updateBlock();
  };

  return (
    <div className="container">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill={isClicked ? "red" : "none"}
        viewBox="0 0 24 24"
        strokeWidth="1.5"
        stroke="currentColor"
        className="w-6 h-6 inline-block"
        onClick={block}
        style={{ cursor: "pointer" }}
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M10.05 4.575a1.575 1.575 0 1 0-3.15 0v3m3.15-3v-1.5a1.575 1.575 0 0 1 3.15 0v1.5m-3.15 0 .075 5.925m3.075.75V4.575m0 0a1.575 1.575 0 0 1 3.15 0V15M6.9 7.575a1.575 1.575 0 1 0-3.15 0v8.175a6.75 6.75 0 0 0 6.75 6.75h2.018a5.25 5.25 0 0 0 3.712-1.538l1.732-1.732a5.25 5.25 0 0 0 1.538-3.712l.003-2.024a.668.668 0 0 1 .198-.471 1.575 1.575 0 1 0-2.228-2.228 3.818 3.818 0 0 0-1.12 2.687M6.9 7.575V12m6.27 4.318A4.49 4.49 0 0 1 16.35 15m.002 0h-.002"
        />
      </svg>
    </div>
  );
};

export default Block;
