# DealFlow — Investor Deal Management App

A Flutter app where investors can browse investment deals, filter them, and save their interests.

---

## 📸 Screenshots
<p align="center">
  <img src="screenshots/splash_screen.png" width="200"/>
  <img src="screenshots/login_screen.png" width="200"/>
  <img src="screenshots/home_screen.png" width="200"/>
 <img src="screenshots/detail_screen1.png" width="250"/>
  <img src="screenshots/detail_screen2.png" width="250"/>
  <img src="screenshots/filter_screen.png" width="250"/>
<img src="screenshots/applyed_filter_screen.png" width="250"/>
  <img src="screenshots/intrested_screen.png" width="250"/>
</p>

## ▶️ How to Run

```bash
https://github.com/tushar-gadekar/flutter_task.git
cd assignment
flutter pub get
flutter run
```

**Login Credentials**
```
Email:    investor@demo.com
Password: demo123
```

---

## 📦 What's Inside

- **Splash + Login** — Animated splash screen, mock auth with session (stays logged in on reopen)
- **Deal Listing** — Browse deals with company name, industry, ROI, risk level, and status
- **Search** — Search deals by company name in real-time
- **Filter** — Filter by risk level (Low / Medium / High), industry, and ROI range — active filters shown as removable chips
- **Deal Detail** — Full company info, financials, ROI bar chart, risk explanation
- **Express Interest** — Tap "I'm Interested" on any deal to save it locally with instant UI update
- **Remove Interest** — Remove interest from deal card or detail screen, reflects instantly everywhere
- **My Interests** — View all saved deals in one place and manage them

---

## 🛠️ Tech Used

| Framework | Flutter (Dart) |
| State Management | BLoC |
| Local Storage | SharedPreferences |
| Architecture | Clean Architecture (Domain / Data / Presentation) |
| Data | Mock JSON with simulated API delay |

---

**Tushar Gadekar** — Flutter Developer  
[LinkedIn](https://www.linkedin.com/in/tusharsgadekar/) • [GitHub](https://github.com/tushar-gadekar)
