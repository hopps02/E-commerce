# 📌 Captain Home

> The captain's landing screen: availability toggle plus three swipeable order queues (upcoming / in-delivery / completed).

---

## 🎯 Purpose

Gives a delivery captain a single dashboard to see their work. It greets them by name, shows an availability pill, and exposes three paginated order queues so they can pick up upcoming jobs, track active deliveries, and review completed ones.

---

## 🧱 Key Classes

- `CaptainHomeView` — main screen (NestedScrollView + tabs + carousel)
- `CaptainHomeNotifier` (`captainHomeController`) — handles tab change, availability toggle, per-queue load/refresh/pagination, profile load
- `GetCaptainOrdersUseCase` — fetches one queue page (`CaptainOrdersParams`)
- `SetCaptainAvailabilityUseCase` / `GetCaptainProfileUseCase` — toggle availability, load greeting name + real availability
- `CaptainOrder` / `CaptainOrdersPage` — backend contract (list + paging `meta`)

---

## 🔁 Flow (brief)

UI → CaptainHomeNotifier → GetCaptainOrders/Profile/Availability UseCase → Repository → CaptainApi → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- The three tabs and the carousel are **one** controller — tabs are not separate routes. Tapping a tab calls `carouselController.animateToPage`, and manual swipes feed back via `onTabChange` (`reason == manual` only, to avoid loops). Carousel swipe physics are disabled; navigation is tab-driven.
- `loadInitial` loads **all three queues + profile in parallel** on build (via `Future.microtask`), not lazily per tab.
- Availability toggle is **optimistic**: the pill flips instantly, then rolls back and shows a snackbar if the backend refuses. The pill must never lie.
- Profile load overrides the optimistic default: greeting name and the authoritative `isAvailable` come from `/captain/me`; on failure the header silently keeps its defaults.
- Each queue has its own `RefreshController` (pull-to-refresh + infinite scroll). `hasMore` is computed from paging meta (`page * pageSize < total`); `loadMore` calls `loadNoData()` when exhausted.
- Screen uses `AutomaticKeepAliveClientMixin` (wantKeepAlive) so state survives bottom-nav switches. Controller is `autoDispose`.

---

## 🔗 Related

- API endpoints: `GET /captain/orders?queue=&page=&page_size=`, `GET /captain/me`, `PATCH /captain/availability` (full schema in Postman)
- Linked features: `captain_order_details`, `captain_delivery_outcome`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
