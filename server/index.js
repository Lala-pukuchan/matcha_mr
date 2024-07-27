const http = require('http');
const { Server } = require("socket.io");
const app = require('./app');

const corsOptions = {
  origin: ["http://localhost:1080", "http://localhost:3000"],
  credentials: true,
  methods: ["GET", "POST"],
  transport: ["websocket"],
  optionsSuccessStatus: 200
};

const server = http.createServer(app);
const io = new Server(server, {
  cors: corsOptions,
  transports: ['websocket', 'polling'],
});

const PORT = 4000;

// dbService
const pool = require('./services/dbService');

// WebSockethandler
const { setupSocket } = require('./sockets/socketHandler');
setupSocket(io, pool);

// Start server
server.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
