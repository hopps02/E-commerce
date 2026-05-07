# 📌 Auth Success

> Transient, celebratory screen shown immediately after successful OTP verification.

---

## 🎯 Purpose

The `AuthSuccessView` provides visual confirmation and UX delight after a user successfully logs in. It serves as a transition point that cleans up the navigation state before entering the main application.

- Display a success Lottie animation and localized message
- Automatically clear the navigation stack to prevent returning to the login flow
- Route the user to the `HomeView` after a short 2–3 second delay

---

## 🧱 Key Classes

- `AuthSuccessView` — main entry point (StatefulWidget)
- `AuthSuccessBody` — UI component containing the Lottie animation and text

---

## 🔁 Flow (brief)

OtpBottomSheet → AuthSuccessView → [2s Delay] → Navigator.pushNamedAndRemoveUntil('/home')

---

## ⚠️ Gotchas / Non-obvious behavior

- **No Notifier**: This feature is purely visual and does not use a Notifier or UseCase. All logic (the navigation timer) resides in the widget's `initState`.
- **Stack Management**: It is critical that this screen uses `pushNamedAndRemoveUntil`. This ensures that when the user reaches the Home screen, the back button (on Android) or swipe-back (on iOS) doesn't take them back to the OTP or Phone entry screens.
- **Local Assets**: The success animation is a local Lottie file to ensure it plays instantly without waiting for a network request.

---

## 🔗 Related

- API endpoints: None.
- Linked features: `Authentication`, `Home`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
