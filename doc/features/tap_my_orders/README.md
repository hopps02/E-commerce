# 📌 My Orders Tab

> Home tab with two paginated lists — current orders and previous orders — swipeable via a carousel.

---

## 🎯 Purpose

Lists the customer's orders split into two status groups (`current` and `previous`), each independently paginated and pull-to-refreshable. It's a Home tab, so it stays alive in the background and loads both groups up front for instant switching.

---

## 🧱 Key Classes

- `TapMyOrdersView` — main screen (Home tab, kept alive)
- `MyOrdersTabNotifier` / `myOrdersTabController` — handles tab switch, initial load, refresh, load-more per group
- `GetCustomerOrdersUseCase` — fetches one page of one status group
- `CustomerOrdersParams` — request DTO (`statusGroup`, `page`)
- `CustomerOrder` + paginated `meta` — response DTOs
- `TapData` — per-group state (orders, page, hasMore); `MyOrdersTabState` holds both + selected tab

---

## 🔁 Flow (brief)

UI → MyOrdersTabNotifier → UseCase → Repository → API → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- **Two status groups, two independent states.** `current` and `previous` each have their own `TapData`, `RefreshController`, and pagination cursor. The group string is passed straight to the API as `status_group`.
- **Both groups load on build** via `loadInitial` (`Future.wait`) so the carousel can switch instantly between them.
- **Pagination math is meta-driven.** `hasMore = page * meta.pageSize < meta.total`. `loadMore` increments page and appends; when exhausted it calls `loadNoData()` on the refresh controller.
- **Empty vs success.** First page maps to `ReqState.empty` when no orders, otherwise `success` — error state carries `failure.displayMessage`.
- **Tab switch animates the carousel**, not just the index — `onTabChange` drives `carouselController.animateToPage`.
- **Kept alive** (`AutomaticKeepAliveClientMixin` + `autoDispose` provider with disposed refresh controllers) — don't expect a fresh load on every tab visit; pull-to-refresh re-fetches the first page.

---

## 🔗 Related

- API endpoints: `GET /mobile/orders?status_group={current|previous}&page&page_size` (full schema in Postman)
- Linked features: `order_details`, `user_home`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
