# 📌 Splash & Session Bootstrap

> Branded launch screen that decides, on cold start, where the user lands.

---

## 🎯 Purpose

Shows the app logo for a fixed delay, then bootstraps the session and routes the
user to the correct destination. It exists to gate the whole app behind three
checks: onboarding seen, a stored token, and a still-valid backend session —
landing each role on its own home.

---

## 🧱 Key Classes

- `SplashView` — main screen (uses the `AfterLayout` mixin to run after first frame)
- `SessionService` — handles session restore via `resolveStart()`, returning a sealed `SessionStart` (`StartHome(role)` / `StartAuth`)
- `GetMeUseCase` — validates the stored token against the backend (`GET /mobile/me`)
- `MeData` / `AuthSession` — backend contract for the current user and role

---

## 🔁 Flow (brief)

UI (timer) → SessionService.resolveStart → GetMeUseCase → Repository → API → route by role

---

## ⚠️ Gotchas / Non-obvious behavior

- Routing is a 3-way gate, in order: if onboarding was never skipped → `onboarding`; else `resolveStart()` decides `StartHome` vs `StartAuth`.
- Role drives the home route via `MobileRole.homeRoute`: `customer → home`, `cashier → cashierHome`, `captain → captainHome`. The app never lets the user pick a role — the backend assigns it at verify-otp.
- Offline must not lock anyone out: if `GET /mobile/me` fails with a transient error (timeout, 5xx, no internet) the stored role still wins. Only a 401 or `account_suspended` is treated as a dead session and clears local storage → `auth`.
- A token persisted before role-persistence existed (no stored role) is treated as stale: local cleared → `auth`.
- The redirect runs inside a `Timer(Constants.splashTimer)` in `afterLayout`; every navigation is guarded by `context.mounted` because it resolves async.

---

## 🔗 Related

- API endpoints: `GET /mobile/me` (full schema in Postman)
- Linked features: `onboarding`, `auth`, `user_home` (and cashier/captain homes)

---

_Last updated: 2026-06-14 · Owner: Antigravity_
