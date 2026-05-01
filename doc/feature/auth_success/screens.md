# 🖥️ Auth Success Screens

---

## 📱 AuthSuccessView

**Purpose:**
Transitional screen that confirms successful OTP verification and auto-routes the user to the main application hub.

---

### 🧩 Components

* `AuthSuccessBody` → Lottie animation + localized congratulatory message
* Lottie asset: `assets/lottie_animations/success.json` (or similar)

---

### 🔗 State Management

* No Notifier/ViewModel
* Logic lives in `initState` using `Future.delayed`

---

### ⚡ Actions

* No user-triggered actions
* Auto-navigates to `HomeView` after ~2–3 seconds via `pushNamedAndRemoveUntil`

---

### ⚠️ States

* Single state: animation playing → auto-navigate
* No Loading / Error / Empty states needed
