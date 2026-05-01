# 🌐 Authentication API

---

## 🔹 Auth Init

**URL:** `/auth/init`
**Method:** `POST`

---

### 📤 Request

```json
{
  "dialCode": "+966",
  "phoneNumber": "5XXXXXXXX"
}
```

---

### 📥 Response

> ⚠️ API not yet integrated — response structure TBD

---

### ❌ Errors

* 400 → Bad request (invalid phone number)
* 429 → Too many requests (OTP rate limit)
* 500 → Server error

---

## 🔹 Verify OTP *(Planned)*

**URL:** `/auth/verify`
**Method:** `POST`

---

### 📤 Request

> ⚠️ Not yet implemented

---

### 📥 Response

> ⚠️ Not yet implemented — expected to return JWT token or session

---

### ❌ Errors

* 400 → Invalid OTP
* 401 → Unauthorized / expired OTP
* 500 → Server error

---

## 🔹 Notes

* Requires authentication: No (pre-login flow)
* Headers: None (public endpoint)
* Timeout behavior: Standard timeout via `fastHandler`
