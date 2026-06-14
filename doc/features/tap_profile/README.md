# 📌 Profile Tab

> The Home "Profile" tab: shows the customer's name/phone and routes to all account actions (edit, favorites, addresses, language, legal, logout, delete account).

---

## 🎯 Purpose

Acts as the account hub inside the Home shell. It loads the customer profile on open, lets the user pull-to-refresh it, and exposes destructive flows (logout, delete account) that must tear the session down cleanly before returning to auth.

---

## 🧱 Key Classes

- `TapProfileView` — main screen (lives inside the Home tab shell)
- `ProfileNotifier` / `profileController` — handles `load`, `refresh`, `updateName`, `deleteAccount`
- `GetProfileUseCase` — fetches the customer profile
- `DeleteAccountUseCase` — soft-deletes the account server-side
- `LogoutUseCase` — revokes the session (invoked via `SessionService.logout()` from `LogoutButton`)
- `CustomerProfile` — backend contract (no request DTO; all are no-arg GET/DELETE)

---

## 🔁 Flow (brief)

UI → Controller → UseCase → Repository → API → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- `profileController` is `autoDispose`; `build()` kicks off `load()` via `Future.microtask`, so the first frame renders empty `ProfileState` placeholders. `TapProfileView` uses `AutomaticKeepAliveClientMixin` so the tab survives swaps and is NOT re-fetched on every tab switch — pull-to-refresh is how you force a re-fetch.
- On `load()` failure the header silently keeps its placeholders (no error UI); `refresh()` drives the `RefreshController` completed/failed state instead.
- Delete account is split across two widgets: `ProfileSettings._deleteAccount` (confirm sheet + nav) calls `profileController.deleteAccount()`, which calls the server then `SessionService.clearLocal()` (token already revoked server-side). Logout is separate — `LogoutButton` calls `SessionService.logout()` directly, not the controller.
- Name fallback: if the API returns a null name, state stores `User${profile.id}` so the avatar/initial is never blank.

---

## 🔗 Related

- API endpoints: `GET /mobile/profile`, `DELETE /mobile/account`, `POST /auth/logout` (full schema in Postman)
- Linked features: `edit_profile`, `favorites`, `addresses`, `language`, `legal_policies`, `help_support`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
