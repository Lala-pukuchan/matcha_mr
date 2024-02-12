import React, { useState, useEffect } from "react";

const Heart = ({ likeFromUserId, likeToUserId, alreadyLiked }) => {
  // update state
  const [isClicked, setIsClicked] = useState(alreadyLiked);

  // update like
  useEffect(() => {
    setIsClicked(alreadyLiked);
  }, [alreadyLiked]);

  const like = () => {
    // update state
    setIsClicked(!isClicked);

    // update like
    let url = "";
    if (isClicked) {
      url = `${process.env.NEXT_PUBLIC_API_URL}/api/unliked`;
    } else {
      url = `${process.env.NEXT_PUBLIC_API_URL}/api/liked`;
    }
    async function updateLike() {
      try {
        const likeJson = JSON.stringify({
          from: likeFromUserId,
          to: likeToUserId,
        });
        const response = await fetch(url, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: likeJson,
        });
        console.log("response: ", response);
        if (response.ok) {
          const responseData = await response.json();
          console.log("responseData: ", responseData);
        } else {
          console.error("updating liked is failed");
        }
      } catch (e) {
        console.error(e);
      }
    }
    updateLike();
  };

  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      strokeWidth="1.5"
      stroke="currentColor"
      className="w-6 h-6"
      fill={isClicked ? "pink" : "none"}
      onClick={like}
      style={{ cursor: "pointer" }}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12Z"
      />
    </svg>
  );
};

export default Heart;
