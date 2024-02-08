"use client";

import React, { createContext, useContext, useState, useEffect } from "react";

const UserContext = createContext({
  user: null,
  setUser: () => {},
});

export const useUser = () => useContext(UserContext);

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const fetchUserInfo = async () => {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/userinfo`,
        {
          credentials: "include",
        }
      );
      if (response.ok) {
        const data = await response.json();
        setUser(data.user);
      } else {
        setUser(null)
      }
    };

    fetchUserInfo();
  }, []);

  return <UserContext.Provider value={user}>{children}</UserContext.Provider>;
};
