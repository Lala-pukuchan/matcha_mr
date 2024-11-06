"use client";
import Link from "next/link";
import NotificationBell from './notificationBell';
import { useUser } from '../../../context/context';
import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchNotifications, clearNotifications } from '../store/notificationSlice';
import { RootState } from '../store/store';

export default function Nav() {
  const { user } = useUser();
  const [isOpen, setIsOpen] = useState(false);
  const dispatch = useDispatch();
  const notifications = useSelector((state: RootState) => state.notifications.notifications);

  useEffect(() => {
    if (user && user.id) {
      dispatch(fetchNotifications(user.id));
    }
  }, [user, dispatch]);

  const handleChatClick = () => {
    dispatch(clearNotifications());
  };

  return (
    <nav className="w-full bg-blue-100 border-b shadow-md">
      <div className="container mx-auto flex items-center justify-between p-4">
        <Link href="/" className={"flex items-center space-x-2"}>
          <img src="/logo.png" alt="Logo" className="h-16 w-48" object-contain/>
        </Link>
        <button
          className="block md:hidden text-gray-800 focus:outline-none"
          onClick={() => setIsOpen(!isOpen)}
        >
          <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16m-7 6h7"></path>
          </svg>
        </button>
        <ul className={`flex-col md:flex-row md:flex space-x-0 md:space-x-4 mt-4 md:mt-0 bg-blue-100 ${isOpen ? 'flex' : 'hidden'} md:flex text-gray-600 text-lg`}>
          {user ? (
            <>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/">Home</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/recommendUser">RecommendUser</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/searchUser">SearchUser</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/myAccount">MyAccount</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/chat">Chat</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <NotificationBell />
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/logout">Logout</Link>
              </li>
            </>
          ) : (
            <>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/login">Login</Link>
              </li>
              <li className="bg-blue-100 p-2 rounded-md">
                <Link href="/signup">Signup</Link>
              </li>
            </>
          )}
        </ul>
      </div>
    </nav>
  );
}