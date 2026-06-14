# 📌 Legal & Policies

> Displays the app's terms / legal policy text in a scrollable view.

---

## 🎯 Purpose

A read-only screen reached from the Profile tab that shows the legal/terms content. It is currently a static, placeholder-content screen with no real data source.

---

## 🧱 Key Classes

- `LegalPoliciesView` — main screen (app bar + `FastStateRender` + body)
- `LegalPoliciesNotifier` / `legalPoliciesController` — holds a `ReqState` only; no fetch logic
- `LegalPoliciesBody` — the scrollable list of `PolicySection`s
- No use case / DTO — content is hard-coded, not fetched

---

## 🔁 Flow (brief)

UI → Controller (state only, no fetch) → static content rendered

---

## ⚠️ Gotchas / Non-obvious behavior

- This is a simple, effectively-static screen. The controller's `build()` returns `ReqState.success` immediately and never calls a use case or repository — `FastStateRender` therefore always shows the body.
- The policy text in `LegalPoliciesBody` is hard-coded Lorem ipsum (one intro section + a `for` loop of 10 identical "Terms" sections). There is NO backend endpoint backing this screen yet; when real content/localized policies are needed, the controller must be given a use case + data source.
- `onRetry` in the view is an empty closure, because there is nothing to retry — wiring it up is part of the future real implementation.

---

## 🔗 Related

- API endpoints: none yet (content is hard-coded)
- Linked features: `tap_profile` (entry point)

---

_Last updated: 2026-06-14 · Owner: Antigravity_
