# 📌 Language

> Lets the user switch the app language (English / Arabic) and have it take effect everywhere immediately.

---

## 🎯 Purpose

A static picker screen (full-screen `LanguageView`, plus a shared `LanguageBottomSheet` used by other roles). Tapping a language calls `easy_localization`'s `setLocale`, which rebuilds the app in the new locale and RTL/LTR direction. There is no controller or backend call here.

---

## 🧱 Key Classes

- `LanguageView` — main screen (full-page list of supported locales)
- `LanguageBottomSheet` — shared sheet variant (cashier/captain/etc.) with a confirm button
- `SupportedLocales` — enum of EN/AR locales
- `LanguageInterceptor` — Dio interceptor that stamps every request with the current locale
- No controller / use case / DTO — locale is client-side only (persisted by `easy_localization`)

---

## 🔁 Flow (brief)

UI → `context.setLocale(locale)` (easy_localization) → app rebuilds → next API call picks up the new `Accept-Language` header

---

## ⚠️ Gotchas / Non-obvious behavior

- This is a simple, mostly-static screen — no Riverpod controller and no API call for the switch itself. The "logic" is the side effect, not state management.
- The real cross-cutting effect: `LanguageInterceptor.onRequest` reads `SCAFFOLD_MESSENGER_KEY.currentContext!.locale` and sets `Accept-Language` on EVERY outgoing request. So changing the language here silently changes the language of all subsequent API responses (localized error messages, product names, etc.) — not just the UI strings.
- It reads `currentContext!` non-null; if the global scaffold-messenger context is ever null this throws. It relies on the app being fully mounted.
- `LanguageView` switches instantly on tap (no confirm); `LanguageBottomSheet` defers the switch until "Confirm" and only calls `setLocale` if the selection actually changed.

---

## 🔗 Related

- API endpoints: none directly — affects all endpoints via the `Accept-Language` header
- Linked features: `tap_profile` (entry point), `edit_profile` (`preferred_locale` field)

---

_Last updated: 2026-06-14 · Owner: Antigravity_
