# 📌 Cashier Home

> The cashier's landing screen: two paginated order queues (Preparation, On the way) with a greeting header.

---

## 🎯 Purpose

Gives the cashier a live, swipeable overview of the orders they must act on, split into a `preparation` queue and an `on_the_way` queue (the latter also includes delivered orders, newest first). It exists so the cashier can triage work without leaving the home tab.

---

## 🧱 Key Classes

- `CashierHomeView` — main screen (keeps state alive via `AutomaticKeepAliveClientMixin`)
- `CashierTabNotifier` / `cashierTabController` — handles tab switching, per-queue pagination, pull-to-refresh, and loading the cashier name
- `GetCashierOrdersUseCase` — fetches one queue page; `GetCashierProfileUseCase` — fetches the greeting name
- `CashierOrder` (`ResponseDto`) — backend order model returned per queue

---

## 🔁 Flow (brief)

UI (tabs + carousel) → CashierTabNotifier → GetCashierOrders / GetCashierProfile UseCase → Repository → API → state update (per-queue `CashierTapData`)

---

## ⚠️ Gotchas / Non-obvious behavior

- The two tabs are driven by a `CarouselSlider` whose own scroll physics are disabled (`NeverScrollableScrollPhysics`); page changes happen only through `onTabChange`, which animates the carousel programmatically.
- Each queue keeps its **own** `CashierTapData` (state, page, hasMore) and its **own** `RefreshController` — they paginate and refresh independently.
- `loadInitial` fires both queues plus the profile in parallel via `Future.microtask` in `build()`, so data loads before first paint without a manual trigger.
- The greeting name is best-effort: if `GetCashierProfileUseCase` fails, the failure is swallowed and the header just keeps its placeholder.
- `hasMore` is computed from `meta.pageSize * page < meta.total`; load-more calls `loadNoData()` on the refresh controller once exhausted.
- Provider is `autoDispose`, but `wantKeepAlive` on the view keeps the widget mounted across bottom-nav tab switches.

---

## 🔗 Related

- API endpoints: `GET /cashier/orders?queue=&page=&page_size=`, `GET /cashier/me` (full schema in Postman)
- Linked features: `cashier_order_details`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
