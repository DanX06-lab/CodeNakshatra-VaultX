require('dotenv').config();
const express = require('express');
const cors = require('cors');

// Import our background services
require('./services/priceWatcher'); 

// Import our new Routes
const vaultRoutes = require('./routes/vaultRoutes');

const app = express();
app.use(cors());
app.use(express.json());

// Mount the routes
app.use('/api/v1/vault', vaultRoutes);

// Keep the Health Check for debugging
app.get('/api/v1/health', (req, res) => {
    res.json({ status: 'Voltx Engine is LIVE', timestamp: new Date() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Voltx Server running on port ${PORT}`);
    console.log(`📡 Tell React Native to hit: http://<YOUR_LOCAL_IP>:${PORT}/api/v1/health`);
});