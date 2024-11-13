import { createSlice, PayloadAction, createAsyncThunk } from '@reduxjs/toolkit';

interface Notification {
  id: string;
  userId: string;
  type: string;
  message: string;
  fromUser: string;
  timestamp: string;
  checked: boolean;
}

interface NotificationState {
  notifications: Notification[];
  unreadCount: number;
}

const initialState: NotificationState = {
  notifications: [],
  unreadCount: 0,
};

export const fetchNotifications = createAsyncThunk(
  'notifications/fetchNotifications',
  async (userId: string) => {
    console.log(`Fetching notifications from API for user ${userId}`);
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/notifications/${userId}`);
    const data = await response.json();
    return data;
  }
);

const notificationSlice = createSlice({
  name: 'notifications',
  initialState,
  reducers: {
    addNotification: (state, action) => {
      // 同じ種類の未読通知を削除
      state.notifications = state.notifications.filter(notification => 
        !(notification.type === action.payload.type && 
          notification.fromUser === action.payload.fromUser && 
          !notification.checked)
      ).concat(action.payload);
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    },
    clearNotifications: (state) => {
      state.notifications = [];
      state.unreadCount = 0;
    },
    markAsRead: (state, action: PayloadAction<string>) => {
      const notification = state.notifications.find(n => n.id === action.payload);
      if (notification) {
        console.log(`Marking notification ${notification.id} as read in state`);
        notification.checked = true;
      }
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    },
    removeNotification: (state, action) => {
      state.notifications = state.notifications.filter(notification => notification.id !== action.payload);
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    }
  },
  extraReducers: (builder) => {
    builder.addCase(fetchNotifications.fulfilled, (state, action) => {
      console.log('Fetched notifications from API', action.payload);
      state.notifications = Array.isArray(action.payload) ? action.payload : [];
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    });
  },
});

export const { addNotification, clearNotifications, markAsRead } = notificationSlice.actions;
export default notificationSlice.reducer;