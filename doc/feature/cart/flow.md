# 🔄 Shopping Cart Flow

---

## 👤 User Flow

1. User opens `CartView` (from bottom navigation or `ProductDetailsView`)
2. Cart items are displayed via `CartItemCard` list
3. User increments/decrements quantity:

   * ✅ Optimistic UI updates instantly → debounce syncs to `CartController`
4. User taps trash icon:

   * ✅ Item removed from cart state
   * If last item removed → empty state shown
5. User taps "Checkout":

   * *(Planned)* → routes to checkout/payment flow

---

## 🔁 System Flow

UI (CartItemCard) → setState (optimistic) → debounce → CartController → *(Planned)* CartRepository → API

---

## ⏱️ Special Logic

* **Debounce timer**: Quantity changes are buffered (e.g., 500ms) to prevent rapid-fire API calls
* **Optimistic UI**: Local `setState` updates immediately; actual state synced asynchronously

---

## ⚠️ Edge Cases

* [ ] User rapidly taps quantity buttons → debounce must coalesce into single update
* [ ] Network failure during quantity sync → show error, revert optimistic update
* [ ] All items removed → empty state via `FastStateRender`
* [ ] Cart loaded with 0 items initially → empty state immediately

---

## 📍 Navigation

* From → `ProductDetailsView` bottom bar / Bottom navigation tab
* To → *(Planned)* Checkout/Payment screen
* Conditions → Checkout CTA only active when cart is non-empty
