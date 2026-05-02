# 🔄 Auth Success Flow

---

## 👤 User Flow

1. User successfully verifies OTP on `OtpBottomSheet`
2. App navigates to `AuthSuccessView`
3. Lottie success animation plays automatically
4. After ~2–3 seconds, app auto-navigates to `HomeView`
5. Navigation stack is fully cleared (user cannot go back to auth)

---

## 🔁 System Flow

OtpBottomSheet (success) → pushNamed AuthSuccessView → Future.delayed → pushNamedAndRemoveUntil HomeView

---

## ⏱️ Special Logic

* **Auto-navigation timer**: `Future.delayed(Duration(seconds: 2))` fires in `initState` to trigger the route replacement.
* **Stack flush**: Uses `pushNamedAndRemoveUntil` with a predicate of `(route) => false` to ensure the entire auth stack is removed.

---

## ⚠️ Edge Cases

* [ ] User presses device back button during animation → should be blocked (no back navigation)
* [ ] App goes to background during delay → navigation should still fire on resume

---

## 📍 Navigation

* From → `OtpBottomSheet` (on successful verification)
* To → `HomeView`
* Conditions → Timer always fires; no user action required
