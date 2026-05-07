const express = require('express');
const router = express.Router();
const vaultController = require('../controllers/vaultController');

// POST requests (Sending data to DB)
router.post('/register', vaultController.registerUser);
router.post('/alert', vaultController.setPriceAlert);

// GET request (Fetching data for the UI)
router.get('/dashboard/:walletAddress', vaultController.getDashboard);

module.exports = router;