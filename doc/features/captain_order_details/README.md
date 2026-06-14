# 📌 Captain Order Details

> Full detail of one order plus the status-driven action footer that drives a captain through accept → start → deliver/fail.

---

## 🎯 Purpose

Shows a single order (customer, address, products, total) and the actions available for its current status. It is the captain's working screen for one delivery and the source of every order state transition.

---

## 🧱 Key Classes

- `CaptainOrderDetailsView` (`CaptainOrderDetailsArgs`) — main screen
- `CaptainOrderDetailsNotifier` (`captainOrderDetailsController`) — handles load + accept / startDelivery / markDelivered / markFailed transitions
- `DeliveryFailureReasonNotifier` (`deliveryFailureReasonController`) — handles the failure-reason bottom sheet (selection + `other` note)
- `GetCaptainOrderDetailUseCase`, `AcceptOrderUseCase`, `StartDeliveryUseCase`, `MarkDeliveredUseCase`, `MarkFailedUseCase` — the domain actions
- `CaptainOrder` + `MarkDeliveredParams` / `MarkFailedParams` — backend contract

---

## 🔁 Flow (brief)

Footer button → CaptainOrderDetailsNotifier → (Accept/Start/MarkDelivered/MarkFailed)UseCase → Repository → CaptainApi → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- Uses the `FastStateRender` pattern keyed on `state.reqState` / `state.msgError`, with `onRetry → load(orderId)`. Load is kicked off in a `postFrameCallback`, not directly in initState.
- The **footer is a state machine**: it renders different buttons per `CaptainOrderStatus` (upcoming → Accept; received → Start + Fail; inDelivery → Confirm + Fail; delivered/cancelled → none). Read-only statuses hide the footer entirely.
- Every transition is **guarded** by the current status (`acceptOrder` requires `isUpcoming`, etc.) and returns `false` if not allowed — guards both client and re-fetched server state.
- Transitions show a global blocking loader (`loadingService.show/hide`), and on success **re-apply the returned order** (`_applyOrder`) rather than re-fetching. On failure they show a snackbar and stay put.
- `_applyOrder` treats a null `uiStatus` as "the order left the captain's queues" → flips to error state showing the raw server `order.state`.
- `markDelivered` sends `{lat, lng}` but currently passes them as **null** (`MarkDeliveredParams` with no coords) — GPS capture is not wired yet.
- `accept` is acknowledge-only — a captain cannot decline an assigned order.
- Cancellation/failure reason box only renders when `status.isCancelled`; the stored value is a backend enum mapped to a localized label via `_failureCopy` (free-text notes live in state-event metadata, not here).
- Failure sheet: the send button stays disabled while `other` is selected with an empty note (`otherNote` mirrors the TextEditingController so widgets rebuild). The reason list is hardcoded today but the state already supports a future API loading/error flow (`retry()`).
- Item names are localized client-side based on the stored language (`_isArabic`); the order **total is backend-authoritative and never recomputed**.

---

## 🔗 Related

- API endpoints: `GET /captain/orders/{id}`, `POST /captain/orders/{id}/accept`, `POST /captain/orders/{id}/start-delivery`, `POST /captain/orders/{id}/mark-delivered`, `POST /captain/orders/{id}/mark-failed` (full schema in Postman)
- Linked features: `captain_home`, `captain_delivery_outcome`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
