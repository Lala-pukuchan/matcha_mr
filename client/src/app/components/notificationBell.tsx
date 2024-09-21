import React, { useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { clearNotifications } from '../store/notificationSlice';

const NotificationBell = () => {
  const notifications = useSelector((state: RootState) => state.notifications.notifications);
  const dispatch = useDispatch();
  const [isOpen, setIsOpen] = useState(false);
  console.log("notifications: ", notifications);

  const handleClearNotifications = () => {
    dispatch(clearNotifications());
    setIsOpen(false);
  };

  return (
    <div className="relative">
      <button onClick={() => setIsOpen(!isOpen)}>
        <span className="bell-icon">🔔</span>
        {notifications.length > 0 && <span className="badge">{notifications.length}</span>}
      </button>
      {isOpen && (
        <div className="absolute right-0 mt-2 w-48 bg-white border rounded shadow-lg">
          <ul>
            {notifications.map((notification) => (
              <li key={notification.id} className="p-2 border-b last:border-0">
                {notification.message}
              </li>
            ))}
          </ul>
          <button onClick={handleClearNotifications} className="w-full p-2 bg-red-500 text-white">
            Clear All
          </button>
        </div>
      )}
    </div>
  );
};

export default NotificationBell;