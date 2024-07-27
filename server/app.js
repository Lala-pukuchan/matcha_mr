const express = require("express");
const app = express();
const cors = require("cors");
const path = require("path");
const cookieParser = require("cookie-parser");
require('dotenv').config();

// Middleware
const corsOptions = {
  origin: ["http://localhost:1080", "http://localhost:3000"],
  credentials: true,
  methods: ["GET", "POST"],
  transport: ["websocket"],
  optionsSuccessStatus: 200 
};
app.use(cors(corsOptions));
app.use(express.json());
app.use(cookieParser());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// Routes
const userRoutes = require('./routes/userRoutes');
const authRoutes = require('./routes/authRoutes');
const messageRoutes = require('./routes/messageRoutes');
const matchRoutes = require('./routes/matchRoutes');
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/messages', messageRoutes);
app.use('/api/matches', matchRoutes);

module.exports = app;
