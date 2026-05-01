# 🔄 Onboarding Flow

---

## 👤 User Flow

1. User opens the app for the first time
2. `SplashView` detects `skipped-on-boarding` is false
3. User is navigated to `OnboardingView`
4. User views the onboarding screen (image, title, description)
5. User taps "Next" or "Login":

   * ✅ Both actions → `StorageService.setSkippedOnBoarding(true)` → navigate to `AuthView`

---

## 🔁 System Flow

SplashView (check storage) → OnboardingView → UserAction → StorageService → AuthView

---

## ⏱️ Special Logic

* Entry animations via `pluseAnimation` extension for smooth visual reveal of text and buttons

---

## ⚠️ Edge Cases

* [ ] User kills app mid-onboarding → `skipped-on-boarding` not yet set → onboarding shows again on relaunch
* [ ] User reopens app after completing onboarding → `skipped-on-boarding = true` → skip directly to `AuthView` or `HomeView`

---

## 📍 Navigation

* From → `SplashView` (first launch only)
* To → `AuthView`
* Conditions → After either "Next" or "Login" button is tapped
