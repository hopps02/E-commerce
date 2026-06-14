# 📌 Edit Profile

> Lets the customer change their display name; the phone is shown read-only.

---

## 🎯 Purpose

A simple form screen pushed from the Profile tab. It pre-fills name and phone from the already-loaded `profileController`, saves the new name via the update-profile use case, and pops back on success.

---

## 🧱 Key Classes

- `EditProfileView` — main screen (app bar + `EditProfileForm`)
- `EditProfileForm` — owns the text controllers and the save action
- `ProfileNotifier` / `profileController` — handles `updateName` (shared with the Profile tab)
- `UpdateProfileUseCase` — updates the customer's name (and/or preferred locale)
- `CustomerProfile` — backend contract; request body is `{ name }` (PATCH builds it inline in the repository)

---

## 🔁 Flow (brief)

UI → Controller → UseCase → Repository → API → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- The phone field is intentionally NOT editable — it is the account's identity. `EditProfileForm` strips the `+966` prefix for display only and never sends it.
- The form reads `ref.read(profileController)` in `initState`, so it depends on the Profile tab having already loaded the profile. Empty name → save is a no-op (returns early).
- `updateName` shows the global `loadingService` overlay, shows a snackbar on failure, and on success overwrites `ProfileState` so the Profile tab reflects the change immediately. The screen only pops when save returns true and the widget is still mounted.
- `updateProfile` in the repository also supports `preferred_locale`, but this screen never sends it (locale is changed in the Language flow).

---

## 🔗 Related

- API endpoints: `PATCH /mobile/profile` (full schema in Postman)
- Linked features: `tap_profile`, `language`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
