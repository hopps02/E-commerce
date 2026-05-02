# 📌 Onboarding

---

## 📖 Overview

Introductory experience for new users, featuring high-quality visual design (gradients + illustrations) that introduces the app and guides users toward authentication.

---

## 🎯 Responsibilities

- Display immersive onboarding content (image, title, description)
- Provide action buttons: "Next" (to auth) and "Login" (direct to auth)
- Persist the onboarding completion state to local storage
- Route user to `AuthView` after interaction

---

## 🧠 System Behavior / Approach

The onboarding flow uses a `Stack`-based layout to layer a full-screen image background, a gradient overlay, and the content section. Entry animations (`pluseAnimation` extension) provide a smooth visual reveal.

Both the "Next" and "Login" buttons trigger the same behavior: marking onboarding as complete via `StorageService` and navigating to the `AuthView`. The distinction is presentational only.

Since the logic is minimal (no async operations, no ViewModel needed), state is managed directly inside the `StatefulWidget`.

---

## 🔁 Data Flow

1. User opens `OnboardingView` (first launch only)
2. User taps "Next" or "Login"
3. `DI().storageService.setSkippedOnBoarding()` is called
4. User is navigated to `AuthView`

---

## 🧱 Architecture Summary

### 📱 Presentation

- `OnboardingView` → Root StatefulWidget; manages the stack of visual layers
- `ImageBackground` → Displays the main promotional illustration
- `GradientBackground` → Provides the dark-to-transparent gradient overlay
- `OnboardingContent` → Contains title, description, and action buttons

- No Notifier — logic is handled within the View's state for simplicity

---

### 🧠 Domain

- No UseCases — no business rules on this screen

---

### 💾 Data

- `StorageService.setSkippedOnBoarding()` → Persists onboarding completion
- **Key**: `skipped-on-boarding` (Boolean)
- Content is hardcoded and localized via `Translation` manager

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
