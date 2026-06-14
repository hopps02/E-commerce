# 📌 Captain Delivery Outcome

> Full-screen success/failure confirmation shown after a captain completes (or fails) a delivery.

---

## 🎯 Purpose

A terminal feedback screen that confirms the outcome of a delivery transition. It reassures the captain the action was recorded (delivered or failed) and routes them back to the home dashboard.

---

## 🧱 Key Classes

- `CaptainDeliveryOutcomeView` (`CaptainDeliveryOutcomeArgs`) — main screen (icon + text + back-home button)
- `CaptainDeliveryOutcomeKind` — enum (`success` / `failure`) that drives icon, copy and colors
- _No controller_ — this screen is a stateless `StatelessWidget`; it owns no state and makes no network calls
- _No request/response DTO_ — the order number arrives via args, already-completed transition lives in `captain_order_details`

---

## 🔁 Flow (brief)

(Order details transition succeeds) → push CaptainDeliveryOutcomeView(kind, orderId) → back-home button → Routes.captainHome

---

## ⚠️ Gotchas / Non-obvious behavior

- This screen does **no work**: it never calls a usecase or controller. The actual `mark-delivered` / `mark-failed` API call already happened in `CaptainOrderDetailsNotifier`; this is purely a confirmation view pushed by `CaptainOrderDetailsFooter` only after the transition returned `true`.
- `kind.isSuccess` drives everything — icon (green check vs red cancel), title/subtitle text, and even font sizes (22sp success vs 20sp failure).
- The "order id" in args is actually the **order number string** (`order.orderNumber`), interpolated into the subtitle via `trNamed`, not the numeric `orderId`.
- Back-home uses `context.goNamed(Routes.captainHome)` (a `go`, not a pop) — it resets the captain to home rather than returning to the order details stack.

---

## 🔗 Related

- API endpoints: none directly (the transition is done by `captain_order_details`: `POST /captain/orders/{id}/mark-delivered`, `POST /captain/orders/{id}/mark-failed`) (full schema in Postman)
- Linked features: `captain_order_details`, `captain_home`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
