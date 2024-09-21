import { createSlice, PayloadAction, createAsyncThunk } from '@reduxjs/toolkit';

interface Notification {
  id: string;
  userId: string;
  type: string;
  message: string;
  fromUser: string;
  timestamp: string;
  checked: boolean; // 既読かどうかを示すプロパティを追加
}

interface NotificationState {
  notifications: Notification[];
}

const initialState: NotificationState = {
  notifications: [],
};

export const fetchNotifications = createAsyncThunk(
  'notifications/fetchNotifications',
  async (userId: string) => {
    const response = await fetch(`http://localhost:4000/api/notifications/${userId}`);
    const data = await response.json();
    return data;
  }
);

const notificationSlice = createSlice({
	name: 'notifications',
	initialState,
	reducers: {
	  addNotification: (state, action: PayloadAction<Notification>) => {
		state.notifications.push({ ...action.payload, checked: false });
	  },
	  clearNotifications: (state) => {
		state.notifications = [];
	  },
	  markAsRead: (state, action: PayloadAction<string>) => {
		const notification = state.notifications.find(n => n.id === action.payload);
		if (notification) {
		  notification.checked = true;
		}
	  },
	},
	extraReducers: (builder) => {
	  builder.addCase(fetchNotifications.fulfilled, (state, action) => {
		state.notifications = Array.isArray(action.payload) ? action.payload : [];
	  });
	},
  });

export const { addNotification, clearNotifications, markAsRead } = notificationSlice.actions;
export default notificationSlice.reducer;