# 📌 Onboarding

> Introductory experience for new users featuring immersive visual design and direct routing to authentication.

---

## 🎯 Purpose

The `OnboardingView` introduces users to the app's value proposition through high-quality illustrations and localized messaging. It ensures that the first-time user experience is polished and leads naturally into account creation.

- Display immersive onboarding content (images, titles, and descriptions)
- Provide clear action buttons: "Next" and "Login"
- Persist the onboarding completion state to local storage to prevent re-display
- Route the user to the `AuthView` to begin the identification process

---

## 🧱 Key Classes

- `OnboardingView` — root screen managing visual layers and state
- `OnboardingContent` — component containing the title, description, and buttons
- `StorageService` — handles persistent storage of the `skipped-on-boarding` flag

---

## 🔁 Flow (brief)

User opens app (first launch) → `OnboardingView` → User taps "Next"/"Login" → `StorageService.setSkippedOnBoarding(true)` → `AuthView`.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Minimalist Architecture**: Because the logic is restricted to a single storage call and a navigation event, this feature does not use a Notifier or UseCase. All logic is handled directly within the `OnboardingView` state.
- **Visual Stacking**: Uses a `Stack` to layer a full-screen image, a gradient overlay for text readability, and the content itself. This produces an "edge-to-edge" premium look.
- **Animations**: Utilizes the `pluseAnimation` extension for subtle entrance effects on content elements.

---

## 🔗 Related

- API endpoints: None.
- Linked features: `Authentication`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
