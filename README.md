# MSE (Motorsport Events) Platform

Welcome to the **MSE** project! This repository contains the complete source code for the MSE platform, an end-to-end solution for managing motorsport events, races, requests, reports, and promotions.

The platform is divided into two main components:
1. **Frontend Dashboard** (Flutter/GetX)
2. **Backend API** (FastAPI)

---

## 🏗️ Project Architecture

```
mse/
├── backend/                  # FastAPI backend
│   └── mse_version_1.0.0/    # Core backend logic, database models, and API endpoints
│
└── mse_dashboard/            # Flutter Web Admin Dashboard
    └── lib/app/              # GetX architecture (Modules, Data, Routes, etc.)
```

---

## 🎨 MSE Dashboard (Frontend)

The frontend is a beautifully designed, responsive Admin Dashboard built with **Flutter** and the **GetX** state management framework. 

### Key Features:
- **Admin Authentication:** Secure login system integrating with backend OAuth2.
- **Race Administration:** View, Create, Update, and Delete race series.
- **Event Management:** Manage individual events under specific race series.
- **Race Requests & Reports:** View incoming requests and user reports with pull-to-refresh capabilities.
- **Promotions:** Send push notifications/promotions globally via the admin interface.
- **Custom UI Components:** Premium glassmorphic effects, modern alerts, and highly responsive dialogs.

### How to Run:
```bash
cd mse_dashboard
flutter pub get
flutter run -d chrome
```

---

## ⚙️ MSE Backend (FastAPI)

The backend is built with **FastAPI** providing high-performance, asynchronous REST APIs. It connects to the database via SQLAlchemy and uses Alembic for migrations.

### Key Features:
- **Authentication:** JWT-based OAuth2 authentication (Admin & Users).
- **CRUD Endpoints:** Full control over Races, Events, Requests, Reports, and Promotions.
- **Admin Seeding:** Built-in scripts (`seed_admin.py`) to easily initialize an admin user.
- **Email/FCM Support:** Firebase Cloud Messaging and email verification built-in.

### How to Run:
```bash
cd backend/mse_version_1.0.0
# Activate your virtual environment
pip install -r requirements.txt
uvicorn app.main:app --reload
```

### Seeding Admin User
To create the initial admin user, run:
```bash
python seed_admin.py
```
*(You can modify the default credentials directly in the `seed_admin.py` file or by passing environment variables).*

---

## 🚀 Tech Stack

**Frontend:**
- Flutter (Web & Mobile)
- GetX (Routing, State Management, Dependency Injection)

**Backend:**
- Python 3
- FastAPI
- SQLAlchemy
- Pydantic

---

## 🛠️ Maintenance & Contribution

- **Routing (Dashboard):** All routes are strictly defined in `app_pages.dart` and `app_routes.dart`.
- **API Provider:** All network calls are centralized in `api_provider.dart` using GetConnect.
- **Theming:** App-wide colors and constants are stored in `app_colors.dart` and `app_constants.dart`.

Happy Coding! 🏎️🏁
