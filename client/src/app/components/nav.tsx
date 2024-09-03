"use client";
import Link from "next/link";
import { useState, useContext } from "react";
import { useUser } from "../../../context/context";
import { NotificationContext } from "../../../context/notification";

export default function Nav() {
  const { user } = useUser();
  const [isOpen, setIsOpen] = useState(false);
  const { notifications = [], clearNotifications } = useContext(NotificationContext); // デフォルト値として空配列を使用

  const handleChatClick = () => {
    clearNotifications();
  };

  return (
    <nav className="w-full bg-blue-100 border-b shadow-md">
      <div className="container mx-auto flex items-center justify-between p-4">
        <Link href="/" className="flex items-center space-x-2">
          <img src="/logo.png" alt="Logo" className="h-16 w-48" />
        </Link>
        <button
          className="block md:hidden text-gray-800 focus:outline-none"
          onClick={() => setIsOpen(!isOpen)}
        >
          <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16m-7 6h7"></path>
          </svg>
        </button>
        <ul className={`flex-col md:flex-row md:flex space-x-0 md:space-x-20 mt-4 md:mt-0 ${isOpen ? 'flex' : 'hidden'} md:flex text-gray-600 text-lg`}>
          {user ? (
            <>
              <li>
                <Link href="/">Home</Link>
              </li>
              <li>
                <Link href="/recommendUser">RecommendUser</Link>
              </li>
              <li>
                <Link href="/searchUser">SearchUser</Link>
              </li>
              <li>
                <Link href="/myAccount">MyAccount</Link>
              </li>
              <li>
                <Link href="/chat" onClick={handleChatClick}>
                  Chat
                  {notifications.length > 0 && (
                    <span className="ml-2 bg-red-500 rounded-full h-3 w-3 inline-block"></span>
                  )}
                </Link>
              </li>
              <li>
                <Link href="/logout">Logout</Link>
              </li>
            </>
          ) : (
            <>
              <li>
                <Link href="/login">Login</Link>
              </li>
              <li>
                <Link href="/signup">Signup</Link>
              </li>
            </>
          )}
        </ul>
      </div>
    </nav>
  );
}
