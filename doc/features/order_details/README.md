# 📌 Order Details

> Shows a single order's status timeline, items, address and totals, and lets the customer rate a delivered order.

---

## 🎯 Purpose

Displays the full detail of one order (status step, line items, delivery address, price summary) and exposes the rating CTA when the backend says the order is eligible. It exists as the post-purchase view reached from the My Orders tab and the order-success screen.

---

## 🧱 Key Classes

- `OrderDetailsView` — main screen (takes `OrderDetailsArgs.orderId`)
- `OrderDetailsNotifier` / `orderDetailsController` — handles load + rate
- `GetCustomerOrderDetailUseCase` — fetches one order by id
- `RateOrderUseCase` — submits a 4-axis rating
- `RateOrderParams` / `RateOrderBody` — rating request DTO
- `CustomerOrder` / `CustomerOrderItem` / `CustomerOrderTotals` — response DTOs

---

## 🔁 Flow (brief)

UI → OrderDetailsNotifier → UseCase → Repository → API → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- **`canRate` is backend-owned.** The rate CTA shows only when the server returns `canRate` (delivered + unrated + inside the rating window). The client never computes eligibility.
- **Rating has 4 required axes** — overall, captain, order-accuracy, delivery-speed. Star widgets emit doubles but ratings travel as integers: each is `round().clamp(1, 5)`. Empty comments are sent as `null`.
- **No refetch after rating.** On success the controller just flips `canRate` to false locally to retire the CTA (one rating per order).
- **Rating uses the global loading overlay** (`loadingService.show/hide`); failures show a snackbar and return `false`.
- **`step`** maps to the timeline: 1 = preparing, 2 = out for delivery, 3 = delivered.
- **Cancel exists in the use-case/API layer but is NOT wired into this screen** — there is no cancel button in `OrderDetailsBody`.
- Controller is `autoDispose`; `load()` is triggered in a post-frame callback and resets state each call (full-screen loading via `FastStateRender`).

---

## 🔗 Related

- API endpoints: `GET /mobile/orders/{id}`, `POST /mobile/orders/{id}/rating`, `POST /mobile/orders/{id}/cancel` (cancel wired in domain only) (full schema in Postman)
- Linked features: `tap_my_orders`, `confirm_order`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
