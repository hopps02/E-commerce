# 📌 Cart Tab (Home wrapper)

> The shopping cart hosted as a first-class bottom-nav tab.

---

## 🎯 Purpose

Wraps the cart so it lives as a tab inside the user home shell, keeping the
bottom navigation bar visible — unlike the pushed `CartView` reached from
product details, which hides it. It re-prices the order each time the tab is
opened so totals stay fresh.

---

## 🧱 Key Classes

- `TapCartView` — tab wrapper (`navIndex = 1`); reuses `CartData` + `CartSummaryBottomBar`
- `CartController` (`cartController`) — owns cart items, subtotal/discount in halalas, empty state
- `CheckoutController` (`checkoutController`) — `load()` validates + prices the cart (delivery fee, totals)
- `BottomNavigationController` — provides `selectedIndex`, used to detect tab reselection
- See the `cart` feature doc for the request/response DTOs (cart validate / checkout quote)

---

## 🔁 Flow (brief)

Tab opened/reselected → CheckoutController.load → UseCase → Repository → API → re-price → summary bar

---

## ⚠️ Gotchas / Non-obvious behavior

- This is mostly a structural wrapper around the existing cart widgets; its only real logic is keep-alive + re-pricing.
- Keep-alive: it uses `AutomaticKeepAliveClientMixin` (`wantKeepAlive => true`) so scroll position and state survive switching tabs. Remember `super.build(context)` is required in `build`.
- Re-pricing happens twice: once in `initState` (via `Future.microtask`) and again every time the cart tab is reselected — it `ref.listen`s `bottomNavigationController.selectedIndex` and calls `checkoutController.load()` when it equals `navIndex` (1). Opening the tab fresh validates/prices; reselecting re-validates.
- The summary bar only renders when `checkout.reqState.isSuccess && !cart.isEmpty`. An empty (or not-yet-priced) cart shows no bottom bar.
- Checkout button pushes `Routes.confirmOrder`. Money is formatted from halalas via `Money.asRiyals(...)`.

---

## 🔗 Related

- API endpoints: `POST /mobile/cart/validate`, `POST /mobile/checkout/quote` (full schema in Postman)
- Linked features: `cart` (the pushed cart + checkout flow), `user_home`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
