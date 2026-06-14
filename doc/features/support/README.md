# 📌 Support (Open Ticket)

> A form where any user can send a support request (name + message).

---

## 🎯 Purpose

Lets the user submit a free-text support message from a simple form. The screen
validates both fields, shows a global loading overlay while "sending", and pops
itself on success. It exists as the user-initiated entry point for opening a
support ticket.

---

## 🧱 Key Classes

- `SupportView` — main screen (`SupportAppBar` + `SupportBody`/`SupportForm` + `SupportSendButton`)
- `SupportNotifier` (`supportController`) — owns the name/message `TextEditingController`s + focus nodes; exposes `send()`; state is a `bool` (true = sent → close page)
- `OpenTicketUseCase` — domain action for opening a ticket (`POST /mobile/tickets`)
- `OpenTicketBody` — backend contract: `title`, `description`, optional `order_id`

---

## 🔁 Flow (brief)

UI (validate + send) → Controller.send → UseCase → Repository → API → state=true → pop

---

## ⚠️ Gotchas / Non-obvious behavior

- The controller is NOT wired to the backend yet. `SupportNotifier.send()` just shows the loading service, waits a hard-coded `Duration(seconds: 1)`, then sets `state = true`. No `OpenTicketUseCase` call happens — the form does not actually submit a ticket. The use case + `POST /mobile/tickets` endpoint exist and are the intended target.
- Closing the page is a side effect of state: `SupportView` does `ref.listen(supportController, ...)` and calls `context.pop()` when the bool flips to true, rather than navigating inline after `send()`.
- Validation lives in the button (`SupportSendButton._onSend`), not the controller: both fields are `Rules.required()`, and the first invalid field's focus node is focused. Keyboard is dismissed before sending.
- `supportController` is `autoDispose`; controllers/focus nodes are disposed via `ref.onDispose`.

---

## 🔗 Related

- API endpoints: `POST /mobile/tickets` (full schema in Postman) — currently unused by the UI
- Linked features: `help_support`, `auth`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
