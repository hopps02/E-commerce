# 🔄 Authentication Flow

---

## 👤 User Flow

1. User opens `AuthView`
2. User selects country code and enters phone number
3. `FieldsValidator` validates the phone format
4. Loading overlay (`loadingService`) appears
5. API request to `/auth/init` is triggered
6. Result:

   * ✅ Success → `OtpBottomSheet` is displayed
   * ❌ Failure → Error message shown to user

7. User enters 5-digit OTP in `OtpBottomSheet`
8. User taps "Verify"
9. Result:

   * ✅ Success → Navigate to `AuthSuccessView`
   * ❌ Failure → Error message shown, user can retry

---

## 🔁 System Flow

UI → Notifier → UseCase → Repository → API → Response → UI

---

## ⏱️ Special Logic

* **OTP Countdown Timer**: 60-second countdown managed by `VerifyOtpNotifier`. Resend button is disabled until timer reaches zero.
* **Resend OTP**: Re-triggers `AuthInitUseCase` and resets the timer.

---

## ⚠️ Edge Cases

* [ ] Invalid phone number format
* [ ] Network failure during `/auth/init`
* [ ] Incorrect OTP code entered
* [ ] OTP expires before user submits
* [ ] Too many OTP requests (429 rate limit)

---

## 📍 Navigation

* From → `OnboardingView` or `SplashView` (when user is not authenticated)
* To → `AuthSuccessView` (on successful OTP verification)
* Conditions → Only navigates after successful OTP verification
