# DealFlow — Investor Deal Management App

A Flutter app where investors can browse investment deals, filter them, and save their interests.

---

## 📸 Screenshots
![Splash](screenshots/splash_screen.png)
![Login](screenshots/login_screen.png)
![Home Screen](screenshots/home_screen.png)
![Detail Screen1](screenshots/detail_screen1.png)
![Detail Screen2](screenshots/detail_screen2.png)
![Filter Screen](screenshots/filter_screen.png)
![Already Filter Screen](screenshots/applyed_filter_screen.png)
![Intrested Screen](screenshots/intrested_screen.png)


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
