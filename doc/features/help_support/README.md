# 📌 Help & Support (FAQ)

> Static help screen: an expandable FAQ list with contact options.

---

## 🎯 Purpose

A self-service help page for customers. It renders a fixed set of expandable
FAQ tiles (what we do, becoming a partner, delivery/refund policy) so users can
answer common questions before reaching out. It is presentation-only — no data
is fetched.

---

## 🧱 Key Classes

- `HelpSupportView` — main screen (`HelpSupportAppBar` + `HelpSupportBody`)
- `HelpSupportNotifier` (`helpSupportController`) — holds a `HelpSupportState` (just a `ReqState`); no events, no fetching
- `CustomActionTile` — expandable FAQ row
- `SupportContactCard` — phone/contact card (title + description + tap)
- (No request/response DTOs — there is no backend call.)

---

## 🔁 Flow (brief)

UI → Controller (static state) → no UseCase / Repository / API

---

## ⚠️ Gotchas / Non-obvious behavior

- There is no backend. `HelpSupportNotifier.build()` returns `ReqState.success` immediately, so `FastStateRender` always shows the body. `onRetry` is a no-op.
- All FAQ content is hard-coded placeholder text (Lorem ipsum) and every tile's `onTap` is empty — the copy and any deep-links are still TODO.
- `SupportContactCard` exists in the UI kit (phone icon, tap callback) but is not currently mounted in `HelpSupportBody`; the body only renders FAQ `CustomActionTile`s. The contact-channel wiring (e.g. dialing) is not implemented here yet.
- For an actual support request (free-text message), see the separate `support` feature — this screen does not open tickets.

---

## 🔗 Related

- API endpoints: none
- Linked features: `support` (open ticket), `profile`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
