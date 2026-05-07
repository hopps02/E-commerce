# 📌 Shopping Cart

> Summary of selected products with real-time quantity mutations, dynamic price calculations, and checkout entry.

---

## 🎯 Purpose

The `CartView` provides a centralized space for users to review their selection before purchasing. It handles complex quantity logic and price breakdowns while maintaining a responsive user interface.

- Display a list of cart items with product details, weight, and quantity
- Allow quantity increment/decrement and item removal
- Calculate and display real-time price breakdown (subtotal, shipping, discount, total)
- Handle empty cart state with a localized Lottie animation
- Provide a persistent entry point for the checkout process

---

## 🧱 Key Classes

- `CartView` — primary screen using FastStateRender for state handling
- `CartController` — Notifier managing cart mutations (update quantity, remove item)
- `CartItemCard` — modular component for individual items with local quantity logic
- `CartSummaryBottomBar` — fixed-position price breakdown and checkout button

---

## 🔁 Flow (brief)

User arrives at CartView → CartController loads state → UI renders items or empty state.

User interaction (+/-):
Local UI update (optimistic) → Debounce timer → CartController.updateQuantity() → State sync.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Optimistic UI with Debouncing**: To provide a snappy feel, quantity changes are reflected immediately in the card's local state. A debounce timer (e.g., 500ms) ensures that the underlying `CartController` and future API calls aren't spammed with every rapid tap.
- **Automatic Empty State**: When the last item is removed, `FastStateRender` automatically triggers the empty state view, showing a Lottie animation and a "Shop Now" call to action.
- **Persistent Summary**: The price breakdown and checkout button are anchored to the bottom of the screen, ensuring visibility regardless of how many items are in the scrollable list.

---

## 🔗 Related

- API endpoints: `GET /cart`, `POST /cart/update` (Planned)
- Linked features: `ProductDetailsView`, `HomeView` (via tab switch).

---

_Last updated: 2026-05-07 · Owner: Antigravity_
