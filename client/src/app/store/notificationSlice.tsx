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
    const response = await fetch(`http://localhost:4000/api/notifications/${userId}`);
    const data = await response.json();
	console.log("data:", data);
    return data;
  }
);

const notificationSlice = createSlice({
  name: 'notifications',
  initialState,
  reducers: {
    addNotification: (state, action: PayloadAction<Notification>) => {
      state.notifications.unshift({ ...action.payload, checked: false });
      if (state.notifications.length > 10) {
        state.notifications.pop();
      }
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    },
    clearNotifications: (state) => {
      state.notifications = [];
    },
    markAsRead: (state, action: PayloadAction<string>) => {
      const notification = state.notifications.find(n => n.id === action.payload);
      if (notification) {
        notification.checked = true;
      }
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchNotifications.fulfilled, (state, action) => {
      state.notifications = Array.isArray(action.payload) ? action.payload : [];
      state.unreadCount = state.notifications.filter(notification => !notification.checked).length;
    });
  },
});

export const { addNotification, clearNotifications, markAsRead } = notificationSlice.actions;
export default notificationSlice.reducer;