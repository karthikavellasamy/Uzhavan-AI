# Uzhavan AI (உழவன் AI) — Smart Farming Assistant

> **Smart Farming. Better Decisions.**  
> அறிவார்ந்த விவசாயம். சிறந்த முடிவுகள்.

**Uzhavan AI** is a complete, modern, responsive, AI-powered Smart Farming Web Application built specifically for Indian and Tamil Nadu farmers. It integrates real-time meteorological weather and alerts, AI-driven crop disease diagnosis and voice assistance, interactive farming calendar planners, verified AGMARKNET & e-NAM mandi prices, comprehensive central & state government schemes, and personalized farm land management — with full native **Tamil (தமிழ்)** and **English** bilingual interfaces.

---

## 🌟 Key Features

1. **🌾 Personalized Farmer Dashboard**
   - Native greeting ("வணக்கம்" / "Welcome") with farmer's name, landholding size, and soil/crop details.
   - Live local weather overview, humidity, wind velocity, and precipitation chances.
   - Clearly labeled practical agricultural advisories:
     - **Irrigation Guidance** (adapts to forecasted rainfall or high temperatures).
     - **Spraying Advisory** (alerts when wind speed >15 km/h or rain probability >40%).
   - Today's farming activities and upcoming planting/fertilization/harvesting reminders.
   - Spotlight on verified local mandi rates.

2. **🌦️ Real-Time Weather Module**
   - Geolocation auto-detection via browser GPS (with farmer permission).
   - Instant search across all 35 Tamil Nadu districts and Indian cities.
   - Temperature, feels-like, min/max, atmospheric pressure, humidity, cloud cover, and sunrise/sunset times.
   - 24-Hour hourly forecast and 5-Day daily trend outlook.
   - Connects to OpenWeatherMap API with graceful error handling and retry options.

3. **🤖 AI Crop Disease & Agronomy Doctor (Gemini Multimodal)**
   - Specialized agricultural safety diagnosis protocol:
     - Identifies crop and visible symptoms from verbal description or uploaded leaf photos.
     - Offers preliminary causes, field checks to verify, and Integrated Pest Management (IPM) safe cultural practices.
     - Enforces pesticide label safety instructions and recommends contacting local Krishi Vigyan Kendras (KVKs) or Agricultural Officers.
   - Save advice to bookmarks and copy answers with one click.
   - Supports native Tamil and English conversations.

4. **🎙️ Bilingual AI Voice Assistant**
   - Tap-to-speak interface powered by Web Speech API (`webkitSpeechRecognition` & `SpeechRecognition`).
   - Supports **Tamil (`ta-IN`)** and **English (`en-IN`)**.
   - Real-time recognized speech preview with inline text editing before sending.
   - Voice read-aloud via Web Speech Synthesis with dedicated play/pause/stop audio controls.

5. **📅 Farming Calendar & Planner**
   - Plan, track, and manage activities: Land Preparation, Sowing, Transplanting, Irrigation, Fertilizer, Weed Management, Pest Inspection, and Harvesting.
   - **Smart AI Schedule Generator**: Enter your crop, sowing date, and soil type — Uzhavan AI will draft a complete seasonal farming roadmap!
   - Persistent MySQL storage with status toggles (`Planned`, `In Progress`, `Completed`).

6. **📈 Live Mandi Market Prices**
   - Verified commodity arrival data from official sources: **AGMARKNET** and **e-NAM**.
   - Commodities include Tomato (தக்காளி), Onion (வெங்காயம்), Paddy (நெல்), Maize (மக்காச்சோளம்), Groundnut (நிலக்கடலை), Cotton (பருத்தி), Banana (வாழை), Chilli (மிளகாய்), Turmeric (மஞ்சள்), Coconut (தேங்காய்).
   - Modal prices, Min/Max price ranges, arrival dates, and market sources across Tamil Nadu regulated mandis.
   - Sort by price or filter by district and commodity.

7. **🏛️ Government Schemes Portal**
   - Verified central and Tamil Nadu state agricultural schemes:
     - **PM-KISAN** (₹6,000/year direct income support).
     - **PMFBY** (Pradhan Mantri Fasal Bima Yojana - Crop Insurance).
     - **Tamil Nadu Micro Irrigation Scheme** (100% drip subsidy for small/marginal farmers).
     - **TNEB Free Electricity Scheme** (Free power for farm pumpsets).
     - **SMAM** (Farm machinery and tractor subsidies).
     - **Kisan Credit Card (KCC)** (Low-interest crop loans at 4%).
     - **Soil Health Card Scheme** (Free soil nutrient testing).
     - **Kalaignarin Scheme** (Integrated agricultural village development).
   - Eligibility, benefits, required documents, application instructions, and official portal links.

8. **🚜 My Farm & Field Plots Management**
   - Record multiple field plots with separate soil types, irrigation infrastructure, and active crops.
   - Edit personal details, language preferences, and contact information.

---

## 🛠️ Technology Stack

- **Frontend**: React 18, TypeScript, Vite, Tailwind CSS, Lucide Icons, React Router v6.
- **Backend**: Node.js, Express, TypeScript, RESTful API architecture.
- **Database**: MySQL 8.4+ (InnoDB, UTF-8 MB4 Unicode) with automated table initialization and persistent fallback engine.
- **Security**: Password hashing with `bcryptjs`, JWT bearer authentication tokens, sanitized parameterized queries.
- **AI Engine**: Google Gemini API (`gemini-2.5-flash`, `gemini-1.5-flash`).
- **Meteorology**: OpenWeatherMap REST API.
- **Market Data**: Official AGMARKNET & e-NAM daily mandi arrival reporting structures.

---

## 📁 Project Directory Structure

```
Uzhavan AI/
├── .env.example                # Root environment configuration template
├── README.md                   # Complete documentation and setup guide
├── backend/
│   ├── .env.example            # Backend env template
│   ├── .env                    # Active backend environment file
│   ├── package.json
│   ├── tsconfig.json
│   ├── src/
│   │   ├── index.ts            # Server entry point and API route mounting
│   │   ├── config/
│   │   │   └── database.ts     # MySQL connection pool
│   │   ├── db/
│   │   │   ├── schema.sql      # MySQL tables schema
│   │   │   ├── initDb.ts       # Database creator and migrator
│   │   │   └── repository.ts   # Persistent repository layer
│   │   ├── middleware/
│   │   │   └── auth.ts         # JWT bearer authentication middleware
│   │   ├── routes/
│   │   │   ├── auth.ts         # Register, Login, Me, Language
│   │   │   ├── profile.ts      # Farmer profile and onboarding
│   │   │   ├── fields.ts       # Field plots management
│   │   │   ├── weather.ts      # Live weather and 35 TN districts
│   │   │   ├── ai.ts           # Gemini AI agricultural doctor & schedules
│   │   │   ├── calendar.ts     # Farm activities planner
│   │   │   ├── market.ts       # Live mandi rates
│   │   │   └── schemes.ts      # Verified government schemes
│   │   ├── services/
│   │   │   ├── geminiService.ts
│   │   │   └── weatherService.ts
│   │   └── data/
│   │       ├── schemesData.ts
│   │       └── verifiedMarketData.ts
│   └── test_api.ps1            # Automated verification test script
└── frontend/
    ├── index.html
    ├── package.json
    ├── vite.config.ts          # Vite configuration with /api proxy to backend
    ├── tailwind.config.js      # Agriculture color palette (agri & earth tones)
    └── src/
        ├── main.tsx
        ├── App.tsx             # Route definitions and responsive layout
        ├── i18n/
        │   ├── LanguageContext.tsx
        │   └── translations.ts # Full Tamil & English dictionaries
        ├── context/
        │   └── AuthContext.tsx # JWT session persistence
        ├── services/
        │   ├── api.ts          # Typed API client
        │   └── speech.ts       # Speech Recognition and Synthesis
        ├── components/
        │   ├── Navbar.tsx      # Responsive header with language toggle
        │   ├── Sidebar.tsx     # Desktop dashboard sidebar navigation
        │   ├── Footer.tsx      # Agriculture-themed footer
        │   └── ProtectedRoute.tsx
        └── pages/
            ├── LandingPage.tsx
            ├── LoginPage.tsx
            ├── RegisterPage.tsx
            ├── OnboardingPage.tsx
            ├── DashboardPage.tsx
            ├── WeatherPage.tsx
            ├── DiseaseHelpPage.tsx
            ├── VoiceAssistantPage.tsx
            ├── CalendarPage.tsx
            ├── MarketPricesPage.tsx
            ├── SchemesPage.tsx
            ├── MyFarmPage.tsx
            └── ProfilePage.tsx
```

---

## 🚀 Getting Started

### 1. Prerequisites
- **Node.js**: v18.0.0 or higher (v24+ tested)
- **MySQL**: MySQL 8.0+ / 8.4+ running locally (Service `MySQL84` on port `3306`)

### 2. Configure Environment Variables
Open `backend\.env` and configure your settings:

```env
PORT=5000
NODE_ENV=development

# MySQL Database Credentials
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_mysql_password_here
DB_NAME=uzhavan_ai

# JWT Auth Secret
JWT_SECRET=uzhavan_ai_production_jwt_secret_987654321

# Google Gemini API Key (Get free key at: https://aistudio.google.com/)
GEMINI_API_KEY=your_gemini_api_key_here

# OpenWeatherMap API Key (Get free key at: https://openweathermap.org/api)
OPENWEATHER_API_KEY=your_openweather_api_key_here
```

### 3. Initialize Database (MySQL)
Run the automated schema creator to create the `uzhavan_ai` database and all tables:
```powershell
cd "backend"
npm run init-db
```

### 4. Start Backend Server
```powershell
cd "backend"
npm run dev
# Or run compiled production build:
# npm run build
# npm start
```
The backend API server will run at `http://localhost:5000`.

### 5. Start Frontend Application
In a new terminal window:
```powershell
cd "frontend"
npm run dev
```
Open your browser and navigate to `http://localhost:3000`.

---

## 🧪 Testing the Application End-to-End

To verify all backend endpoints, authentication, database persistence, and market data:
```powershell
cd "backend"
powershell -ExecutionPolicy Bypass -File "test_api.ps1"
```

---

## 🌾 User Journey Checklist

1. **Language Switcher**: Toggle between **தமிழ்** and **English** anytime from the top bar. All navigation links, labels, advisory messages, and forms update instantly.
2. **Farmer Registration**: Sign up with Name, Mobile, District, and Village. Passwords are securely hashed with `bcryptjs`.
3. **Onboarding**: Record your farm's acreage, soil type, irrigation system, and main crops (e.g. Tomato, Paddy).
4. **Personalized Dashboard**: Check your personalized weather, today's irrigation advice, spraying cautions, and calendar reminders.
5. **Weather**: Search any city or district across Tamil Nadu or click "Use My Current Location" for GPS-based forecasts.
6. **AI Crop Doctor**: Ask agricultural questions or upload leaf images to diagnose pests and diseases with Integrated Pest Management guidance.
7. **Voice Assistant**: Tap the microphone, speak in Tamil, verify the recognized text, and listen to the AI answer spoken aloud.
8. **Farming Calendar**: Add activities or click **Smart AI Schedule Generator** to build a complete seasonal calendar for your crop.
9. **Live Mandi Rates**: Explore official AGMARKNET wholesale rates by district or commodity.
10. **Government Schemes**: Browse PM-KISAN, crop insurance, and free electricity schemes with direct links to official government portals.
