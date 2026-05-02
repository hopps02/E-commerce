# 📌 Auth Success

---

## 📖 Overview

A transient, celebratory screen shown immediately after the user successfully verifies their OTP. It provides visual confirmation before auto-routing to the main app.

---

## 🎯 Responsibilities

- Display a success Lottie animation
- Show a localized congratulatory message
- Automatically clear the navigation stack and route to `HomeView` after a short delay

---

## 🧠 System Behavior / Approach

The Auth Success screen is a micro-feature designed purely for UX delight. It does not require any API calls or complex state management. The screen operates entirely on widget lifecycle methods.

Upon mounting, a `Future.delayed` timer fires after approximately 2–3 seconds and uses `pushNamedAndRemoveUntil` to flush the authentication backstack completely, ensuring the user cannot navigate back to the login flow.

The Lottie animation is stored locally in `assets/lottie_animations/` to guarantee immediate, network-independent playback.

---

## 🔁 Data Flow

1. Navigation arrives from `OtpBottomSheet` after successful OTP verification
2. `AuthSuccessView` mounts → `initState` starts `Future.delayed`
3. Lottie animation plays immediately
4. After delay expires → `Navigator.pushNamedAndRemoveUntil` → `HomeView`

---

## 🧱 Architecture Summary

### 📱 Presentation

- `AuthSuccessView` → Minimal Scaffold; entry point for this screen
- `AuthSuccessBody` → Contains the Lottie animation and localized message
- `AuthSuccessLoading` → *(if applicable)* loading state widget

- No Notifier required — logic lives in widget lifecycle (`initState` / `Future.delayed`)

---

### 🧠 Domain

- No UseCases — this is a purely transitional UI screen

---

### 💾 Data

- No API calls
- No local storage interaction

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
