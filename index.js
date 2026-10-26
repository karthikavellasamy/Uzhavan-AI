import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { checkDbConnection, isDbConnected } from './config/database.js';
import { initializeDatabase } from './db/initDb.js';
// Import Routes
import authRoutes from './routes/auth.js';
import profileRoutes from './routes/profile.js';
import fieldsRoutes from './routes/fields.js';
import weatherRoutes from './routes/weather.js';
import aiRoutes from './routes/ai.js';
import calendarRoutes from './routes/calendar.js';
import marketRoutes from './routes/market.js';
import schemesRoutes from './routes/schemes.js';
dotenv.config();
const app = express();
const PORT = parseInt(process.env.PORT || '5000', 10);
// Middleware
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json({ limit: '15mb' }));
app.use(express.urlencoded({ extended: true, limit: '15mb' }));
// Health Check Endpoint
app.get('/api/health', (_req, res) => {
    res.json({
        status: 'online',
        appName: 'Uzhavan AI (உழவன் AI) Backend API',
        version: '1.0.0',
        timestamp: new Date().toISOString(),
        services: {
            mysqlDatabase: isDbConnected() ? 'connected' : 'fallback-active-awaiting-credentials',
            weatherApiConfigured: !!(process.env.OPENWEATHER_API_KEY && !process.env.OPENWEATHER_API_KEY.includes('your_')),
            geminiAiConfigured: !!(process.env.GEMINI_API_KEY && !process.env.GEMINI_API_KEY.includes('your_'))
        }
    });
});
// Mount Routes
app.use('/api/auth', authRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/fields', fieldsRoutes);
app.use('/api/weather', weatherRoutes);
app.use('/api/ai', aiRoutes);
app.use('/api/calendar', calendarRoutes);
app.use('/api/market', marketRoutes);
app.use('/api/schemes', schemesRoutes);
// Error handling middleware
app.use((err, _req, res, _next) => {
    console.error('Unhandled server error:', err);
    res.status(500).json({
        success: false,
        message: 'An internal server error occurred.',
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});
// Start Server
async function startServer() {
    console.log('🌾 Initializing Uzhavan AI Backend Services...');
    // Attempt database connection & schema sync
    try {
        const connected = await checkDbConnection();
        if (connected) {
            await initializeDatabase();
        }
        else {
            console.log('ℹ️ Uzhavan AI local storage fallback is ready. Database queries will proceed smoothly.');
        }
    }
    catch (dbErr) {
        console.warn('ℹ️ DB initialization note:', dbErr.message);
    }
    app.listen(PORT, '0.0.0.0', () => {
        console.log(`=================================================`);
        console.log(`🚀 Uzhavan AI API Server running at http://localhost:${PORT}`);
        console.log(`🌾 Smart Farming Assistant for Indian Farmers`);
        console.log(`🌱 MySQL: ${isDbConnected() ? 'CONNECTED' : 'STANDBY'}`);
        console.log(`=================================================`);
    });
}
startServer();
