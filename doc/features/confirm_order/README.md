# 📌 Confirm Order (Checkout)

> Final review screen: confirms the delivery address, prices the order via a backend quote, and places a COD order.

---

## 🎯 Purpose

Turns a validated cart into a real order. It re-validates stock, resolves a delivery address, fetches a server-priced quote (delivery fee can differ per zone), and submits the order. It exists so totals and stock are always trusted from the backend, never computed on the client.

---

## 🧱 Key Classes

- `ConfirmOrderView` — main screen (address + line items + confirm CTA)
- `CheckoutNotifier` / `checkoutController` — handles load/quote, address switching, retry, and place-order
- `ValidateCartUseCase` — reconciles cart against live stock/prices
- `CheckoutQuoteUseCase` — prices the order (subtotal + delivery fee + discount)
- `CreateOrderUseCase` — submits the COD order (with idempotency key)
- `CheckoutQuoteParams` / `CreateOrderParams` — backend contract (request DTOs)
- `CheckoutTotals` / `CustomerOrder` — response DTOs

---

## 🔁 Flow (brief)

UI → CheckoutNotifier → (Validate → Quote → CreateOrder) UseCase → Repository → API → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- **Quote vs create are two steps.** Loading the screen only *prices* the order (`checkout/quote`); the order is created only on Confirm. Totals shown are always the server quote, not the cart's local math.
- **Idempotency key.** `placeOrder` sends an `Idempotency-Key` header derived from a fingerprint of `(addressId, lines)`. A double-tap reuses the same key (server dedupes); editing the cart changes the fingerprint and mints a new key. Key is cleared after a successful order.
- **Self-loads on cold open.** `initState` calls `load()` only if the cart screen hasn't already primed a successful state.
- **First-order address fallback.** New customers with no saved address get one auto-created from their picked GPS location, but only after a `coverage-check` confirms the zone is serviceable.
- **Cart reconciliation side effect.** If validation adjusts quantities to stock, a snackbar fires and an emptied cart flips state to `empty`.
- **Place-order uses an in-button spinner** (`placing` flag), not the global loading overlay. Failures surface via snackbar, not the error state.
- COD only — there is no payment step.

---

## 🔗 Related

- API endpoints: `POST /mobile/cart/validate`, `POST /mobile/checkout/quote`, `POST /mobile/orders`, `POST /mobile/location/coverage-check`, `GET/POST /mobile/addresses` (full schema in Postman)
- Linked features: `cart`, `addresses`, `location`, `order_details`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
