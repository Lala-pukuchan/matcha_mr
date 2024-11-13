import React, { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { markAsRead, fetchNotifications } from '../store/notificationSlice';
import { useUser } from '../../../context/context';

const NotificationBell = () => {
  const notifications = useSelector((state: RootState) => state.notifications.notifications);
  const unreadCount = useSelector((state: RootState) => state.notifications.unreadCount);
  const dispatch = useDispatch();
  const [isOpen, setIsOpen] = useState(false);
  const { user } = useUser(); 

  useEffect(() => {
    if (isOpen) {
      // 全ての通知を既読にする
      const markAllAsRead = async () => {
        try {
          for (const notification of notifications) {
            if (!notification.checked) {
              const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/notifications/markAsRead/${notification.id}`, {
                method: 'POST',
              });
              if (!response.ok) {
                throw new Error('Failed to mark notification as read');
              }
              dispatch(markAsRead(notification.id));
            }
          }
        } catch (error) {
          console.error('Error marking notifications as read:', error);
          alert('Failed to mark notifications as read. Please try again later.');
        }
      };
      markAllAsRead();
    }
  }, [isOpen, notifications, dispatch]);

  useEffect(() => {
    if (user && user.id) {
      // ページを更新したときに通知を取得
      dispatch(fetchNotifications(user.id) as any);
    }
  }, [dispatch, user]);

  return (
    <div className="relative">
      <button onClick={() => setIsOpen(!isOpen)}>
        <span className="bell-icon">🔔</span>
        {unreadCount > 0 && <span className="badge">{unreadCount}</span>}
      </button>
      {isOpen && (
        <div className="absolute right-0 mt-2 w-48 bg-white border rounded shadow-lg">
          <ul>
            {notifications.map((notification) => (
              <li key={notification.id} className={`p-2 border-b last:border-0 ${notification.checked ? 'font-normal' : 'font-bold'}`}>
                {notification.message}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default NotificationBell;