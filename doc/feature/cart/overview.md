# 📌 Shopping Cart

---

## 📖 Overview

Provides users with a comprehensive summary of their selected products, handling real-time quantity mutations, dynamic price calculations, and seamless RTL/LTR layout.

---

## 🎯 Responsibilities

- Display a list of cart items with product details, weight, and quantity
- Allow quantity increment/decrement with optimistic UI updates (debounced sync)
- Allow item removal via trash icon
- Calculate and display real-time price breakdown (subtotal, shipping, discount, total)
- Handle empty cart state with a Lottie animation
- Provide a persistent checkout CTA

---

## 🧠 System Behavior / Approach

The cart uses an optimistic UI pattern: quantity changes are reflected immediately in the widget's local state (`setState`) while a debounce timer delays the actual `CartController` update to avoid state-management spam during rapid tapping.

The `CartSummaryBottomBar` is always visible regardless of scroll position, ensuring the user always sees the price summary and the checkout button.

If all items are removed, `FastStateRender` automatically transitions the view to the empty state (Lottie animation + localized message).

---

## 🔁 Data Flow

1. User arrives at `CartView`
2. `CartController` loads cart state (currently mock data; API pending)
3. `FastStateRender` renders loading → success/empty/error
4. User taps +/- → local `setState` → debounce timer → `CartController.updateQuantity()`
5. User taps trash → `CartController.removeItem()`
6. User taps checkout → *(pending)* checkout flow

---

## 🧱 Architecture Summary

### 📱 Presentation

- `CartView` → Primary scaffold; `FastStateRender` wraps `ListView.separated` + bottom bar
- `CartItemCard` → Modular card with local debounce timer for quantity changes
- `CartSummaryBottomBar` → Fixed-position price breakdown and checkout CTA
- `CartAppBar` → Standardized app bar for the cart

- `CartController` → `Notifier<CartState>` managing cart mutations (`updateQuantity`, `removeItem`)

---

### 🧠 Domain

- *(Planned)* `GetCartUseCase` → Fetches active cart items
- *(Planned)* `UpdateCartItemUseCase` → Syncs quantity changes
- *(Planned)* `CheckoutUseCase` → Initiates payment flow

---

### 💾 Data

- *(Current)* Mock data initialized in `CartController`
- *(Planned)* `CartRepository.getCart()`
- *(Planned)* `CartRepository.updateItemQuantity()`
- *(Planned)* `CartRepository.checkout()`

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
