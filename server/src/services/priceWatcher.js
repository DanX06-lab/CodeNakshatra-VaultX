const axios = require('axios');
const { PrismaClient } = require('@prisma/client');
const cron = require('node-cron');

const prisma = new PrismaClient();

const getPrice = async (assetId) => {
    try {
        // Using CoinGecko's free public API
        const response = await axios.get(`https://api.coingecko.com/api/v3/simple/price?ids=${assetId}&vs_currencies=usd`);
        return response.data[assetId].usd;
    } catch (error) {
        console.error("Price fetch failed - CoinGecko might be rate-limiting", error.message);
        return null;
    }
};

// '*/5 * * * *' means run every 5 minutes. 
// Change to '* * * * *' (every 1 min) for the hackathon live demo!
cron.schedule('*/5 * * * *', async () => {
    console.log("🔍 [CRON] Checking market prices...");
    
    const currentPrice = await getPrice('ethereum');
    if (!currentPrice) return;

    console.log(`📉 Current ETH Price: $${currentPrice}`);

    // Find all users who want alerts and haven't been muted
    const activeAlerts = await prisma.priceAlert.findMany({
        where: { asset: 'ethereum', isActive: true }
    });

    for (const alert of activeAlerts) {
        // Calculate percentage drop
        const drop = ((alert.buyPrice - currentPrice) / alert.buyPrice) * 100;
        
        if (drop >= alert.thresholdPct) {
            console.log(`🚨 ALERT TRIGGERED for ${alert.userAddress}! Drop: ${drop.toFixed(2)}%`);
            
            // TODO: Trigger Firebase Push Notification Here
            
            // Turn off the alert so we don't spam them every 5 minutes
            await prisma.priceAlert.update({
                where: { id: alert.id },
                data: { lastNotified: new Date(), isActive: false } 
            });
        }
    }
});