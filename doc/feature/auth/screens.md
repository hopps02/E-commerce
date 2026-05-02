# 🖥️ Authentication Screens

---

## 📱 AuthView

**Purpose:**
Main authentication screen where users enter their phone number and country code to initiate login.

---

### 🧩 Components

* `CountryCodePicker` → allows user to select dial code
* `PhoneTextField` → text input for mobile number
* `SubmitButton` → triggers auth init flow
* `loadingService` overlay → shown during API request

---

### 🔗 State Management

* Connected to `AuthNotifier`
* Observes: country code selection, phone input text, loading state

---

### ⚡ Actions

* Submit button → validates input → calls `AuthInitUseCase` → opens `OtpBottomSheet`

---

### ⚠️ States

* Loading (overlay shown)
* Error (inline error message)
* Success (OTP sheet appears)

---

## 📱 OtpBottomSheet

**Purpose:**
Modal bottom sheet for entering and verifying the 5-digit OTP sent to the user's phone.

---

### 🧩 Components

* `Otp` → OTP input field (5 digits)
* `VerifyOtpButton` → triggers OTP verification
* `ResendOtp` → shows countdown timer; re-enables resend after 60s

---

### 🔗 State Management

* Connected to `VerifyOtpNotifier`
* Observes: OTP text, timer countdown value, resend availability, loading state

---

### ⚡ Actions

* OTP input → updates `VerifyOtpNotifier` state
* Verify button → triggers *(planned)* `VerifyOtpUseCase`
* Resend button (after timer) → re-calls `AuthInitUseCase` and resets timer

---

### ⚠️ States

* Loading
* Success → navigates to `AuthSuccessView`
* Error → shows inline error message
* Timer active (resend disabled)
* Timer expired (resend enabled)
