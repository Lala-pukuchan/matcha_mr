"use client"
import { useEffect } from "react";

export default function users() {

  useEffect(() => {
    
    const queryParams = new URLSearchParams(window.location.search);
    console.log("queryParams", queryParams);
    if (queryParams.get("userID") !== null) {
      console.log("userID", queryParams.get("userID"));
    }
  });

  return (
    <div>
      <h1>User Page</h1>
      {/*<p>User ID: {userID}</p>*/}
      {/* Implement the rest of your user page here */}
    </div>
  );
}
