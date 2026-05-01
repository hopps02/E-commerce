# 📌 Authentication

---

## 📖 Overview

Handles user identity verification via Phone Number and One-Time Password (OTP).

---

## 🎯 Responsibilities

- Accept and validate a mobile phone number input
- Initialize the authentication session via API
- Present an OTP entry bottom sheet after session init
- Manage a 60-second OTP resend countdown timer
- Navigate the user to the Auth Success screen on successful verification

---

## 🧠 System Behavior / Approach

The authentication system is based on phone number and OTP (One-Time Password) verification.

Instead of using email and password, the system relies on sending a temporary code to the user's phone number to verify identity. This reduces friction during onboarding and avoids the need for password management.

The OTP input is presented using a bottom sheet (`OtpBottomSheet`) rather than navigating to a new screen. This allows the user to remain in the same context and complete the verification process quickly.

A countdown timer (60 seconds) is used to control OTP resend functionality. The timer is managed by `VerifyOtpNotifier`, ensuring that users cannot request a new OTP before the cooldown period ends.

---

## 🔁 Data Flow

1. User enters phone number in `AuthView`
2. `AuthNotifier` validates the input using `FieldsValidator`
3. On submit, `AuthNotifier` calls `AuthInitUseCase`
4. `AuthInitUseCase` triggers `Repository.authInit()`
5. Repository sends a POST request to `/auth/init` using `fastHandler`
6. Response is returned as `Either<Failure, AuthInitResponse>`
7. On success:
   - `loadingService` overlay is dismissed
   - `OtpBottomSheet` is displayed
8. User enters OTP
9. `VerifyOtpNotifier` handles OTP input and timer logic
10. *(Planned)* `VerifyOtpUseCase` will verify OTP via API
11. On successful verification:
    - User is navigated to `AuthSuccessView`
12. On failure:
    - Error message is shown to the user

---

## 🧱 Architecture Summary

### 📱 Presentation

- `AuthView` → Main screen for entering phone number and initiating authentication
- `OtpBottomSheet` → Handles OTP input and verification UI

- `AuthNotifier` → Manages phone input, validation, and triggering auth initialization
- `VerifyOtpNotifier` → Manages OTP input, countdown timer, and resend logic

---

### 🧠 Domain

- `AuthInitUseCase` → Initializes authentication session by requesting OTP
- `VerifyOtpUseCase` → *(Planned)* Verifies OTP and completes login process

---

### 💾 Data

- `Repository.authInit()` → Sends authentication request to backend API
- *(Planned)* `Repository.verifyOtp()` → Verifies OTP and retrieves user session/token

- Uses `fastHandler` to wrap responses into `Either<Failure, Success>`

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
