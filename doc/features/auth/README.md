# 📌 Authentication

> Handles user identity verification via Phone Number and One-Time Password (OTP).

---

## 🎯 Purpose

The authentication system verifies user identity using a mobile phone number and a temporary code (OTP). This frictionless approach avoids password management and streamlines onboarding.

- Accept and validate mobile phone number input
- Initialize the authentication session via API (/auth/init)
- Present an OTP entry bottom sheet after session initialization
- Manage a 60-second OTP resend countdown timer
- Navigate the user to the Auth Success screen on successful verification

---

## 🧱 Key Classes

- `AuthView` — main screen for phone entry
- `OtpBottomSheet` — modal for OTP input and verification
- `AuthNotifier` — manages phone input, validation, and triggering initialization
- `VerifyOtpNotifier` — manages OTP input, countdown timer, and resend logic
- `AuthInitUseCase` — domain logic for requesting an OTP session

---

## 🔁 Flow (brief)

1. User enters phone → `AuthNotifier` validates → Calls `AuthInitUseCase`.
2. `AuthInitUseCase` → `Repository.authInit()` → `POST /auth/init`.
3. On Success → `OtpBottomSheet` displays.
4. User enters OTP → `VerifyOtpNotifier` validates → `POST /auth/verify` (Planned).
5. On Success → Navigate to `AuthSuccessView`.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Context Preservation**: OTP is handled in a bottom sheet (`OtpBottomSheet`) rather than a new screen, keeping the user in the same visual context.
- **Resend Cooldown**: A 60-second timer prevents users from requesting multiple OTPs rapidly. The resend button is disabled until the timer expires.
- **Standard Error Handling**: Uses `fastHandler` to ensure all API responses are returned as `Either<Failure, Success>` with consistent error mapping.

---

## 🔗 Related

- API endpoints: `POST /auth/init`, `POST /auth/verify` (Planned)
- Linked features: `Onboarding`, `AuthSuccess`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
