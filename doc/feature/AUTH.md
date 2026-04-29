# Authentication Feature

This document outlines the implementation of the Authentication flow, following the **MVVM + Clean Architecture** pattern.

## 1. Feature Overview
The authentication process handles user identity verification via Phone Number and One-Time Password (OTP). It utilizes a multi-step UI with validation and automated timers.

## 2. User Flow
1. **Phone Input**: User enters their mobile number in `AuthView`.
2. **Validation**: The `FieldsValidator` checks for empty or invalid phone formats before proceeding.
3. **Init Request**: The system shows a loading overlay (`loadingService`) while initializing the auth process.
4. **OTP Verification**: A bottom sheet (`OtpBottomSheet`) appears for the user to enter their 5-digit code.
5. **Timer**: A 60-second countdown (managed by `VerifyOtpNotifier`) controls the "Resend OTP" functionality.
6. **Completion**: Upon verification, the user is navigated to the **Auth Success** screen.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `AuthView`: Main screen with phone input and country code selection.
    - `OtpBottomSheet`: Modular sheet containing the `Otp` input field, `ResendOtp` timer, and `VerifyOtpButton`.
- **ViewModel (Riverpod)**: 
    - `AuthNotifier`: Manages country code state and text field activity.
    - `VerifyOtpNotifier`: Manages the periodic timer (1s intervals) and resend availability.

### Domain
- **UseCase**: `AuthInitUseCase` (Coordinates with the repository to start the session).
- **UseCase**: `[PLACEHOLDER: VerifyOtpUseCase]` (Will handle the server-side verification of the entered OTP).

### Data
- **Repository**: `Repository.authInit()` handles the network request using the `fastHandler` for functional error management (`Either<Failure, Response>`).
- **Endpoints**:
    - `POST /auth/init`: Initializes the session.
    - `[PLACEHOLDER: POST /auth/verify]`: Finalizes the login and returns the JWT token.

## 4. Integration Notes (TODO)
<!-- 
REPLACE THIS SECTION ONCE API IS FULLY CONNECTED
- **AuthInitRequest**: Document the body params (dialCode, phoneNumber).
- **VerifyOtpRequest**: Document the OTP and session ID params.
- **Error Handling**: Document specific failures like "Too Many Requests" or "Invalid OTP Code".
-->

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
