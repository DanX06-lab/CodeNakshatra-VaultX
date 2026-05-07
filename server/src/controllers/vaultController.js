const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// 1. Register User & Save Phone Token (FCM)
exports.registerUser = async (req, res) => {
    try {
        const { walletAddress, fcmToken, email } = req.body;

        // Upsert means: Update if exists, Create if it doesn't
        const user = await prisma.user.upsert({
            where: { walletAddress },
            update: { fcmToken, email },
            create: { walletAddress, fcmToken, email },
        });

        res.status(200).json({ success: true, user });
    } catch (error) {
        console.error("Register Error:", error);
        res.status(500).json({ success: false, error: "Database error" });
    }
};

// 2. Set a Price Alert (The 10% Drop feature)
exports.setPriceAlert = async (req, res) => {
    try {
        const { walletAddress, asset, buyPrice, thresholdPct } = req.body;

        const alert = await prisma.priceAlert.create({
            data: {
                userAddress: walletAddress,
                asset: asset.toLowerCase(),
                buyPrice: parseFloat(buyPrice),
                thresholdPct: parseFloat(thresholdPct)
            }
        });

        res.status(201).json({ success: true, alert });
    } catch (error) {
        console.error("Alert Error:", error);
        res.status(500).json({ success: false, error: "Could not set alert" });
    }
};

// 3. Get Dashboard Status (Frontend calls this on load)
exports.getDashboard = async (req, res) => {
    try {
        const { walletAddress } = req.params;

        const user = await prisma.user.findUnique({
            where: { walletAddress },
            include: { alerts: true } // Fetches their active alerts too!
        });

        if (!user) return res.status(404).json({ success: false, message: "User not found" });

        res.status(200).json({ success: true, data: user });
    } catch (error) {
        res.status(500).json({ success: false, error: "Failed to load dashboard" });
    }
};