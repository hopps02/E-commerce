# 🖥️ Onboarding Screens

---

## 📱 OnboardingView

**Purpose:**
Immersive introductory screen shown to first-time users. Uses layered visuals to introduce the app before directing users to authentication.

---

### 🧩 Components

* `ImageBackground` → Full-screen promotional illustration
* `GradientBackground` → Dark-to-transparent gradient overlay
* `OnboardingContent` → Title, description, and action buttons (`Next` / `Login`)
* `CustomInkButton` → Reusable button with ink ripple effect

---

### 🔗 State Management

* No Notifier/ViewModel
* State managed within `StatefulWidget` directly (minimal logic)

---

### ⚡ Actions

* "Next" button → `setSkippedOnBoarding(true)` → navigate to `AuthView`
* "Login" button → `setSkippedOnBoarding(true)` → navigate to `AuthView`

---

### ⚠️ States

* Single display state — no loading, error, or empty states
* Entry animations on mount via `pluseAnimation` extension
