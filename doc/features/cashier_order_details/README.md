# 📌 Cashier Order Details

> Full order view where the cashier checks off items, confirms readiness, and assigns a delivery captain.

---

## 🎯 Purpose

Shows one order's products, totals, and status, and exposes the cashier's actions: marking items prepared, confirming the order is ready, and assigning an available captain. It is the operational heart of the cashier flow — the queues on Cashier Home just funnel into here.

---

## 🧱 Key Classes

- `CashierOrderDetailsView` (args: `CashierOrderDetailsArgs`) — main screen
- `CashierOrderDetailsNotifier` / `cashierOrderDetailsController` — handles load, toggle-prepared, confirm-ready, apply-assigned
- `AssignCaptainNotifier` / `assignCaptainController` — handles captain list load, search filter, selection, assign-confirm
- `GetCashierOrderDetailUseCase`, `MarkItemPreparedUseCase`, `ConfirmReadyUseCase`, `AvailableCaptainsUseCase`, `AssignCaptainUseCase` — the per-action domain calls
- `CashierOrder` / `AvailableCaptain` (`ResponseDto`); `MarkItemPreparedParams` / `AssignCaptainParams` (`RequestDto`)

---

## 🔁 Flow (brief)

UI (products table + bottom bar) → Controller → UseCase → Repository → API → state update (each successful action re-applies the returned `CashierOrder`)

---

## ⚠️ Gotchas / Non-obvious behavior

- **Optimistic toggle:** `togglePrepared` flips the checkbox in state *before* the network call and rolls the whole product list back (showing a snackbar) if the backend rejects it. It also no-ops unless `status.isProductsEditable`.
- The bottom-bar action button is **dual-purpose**: in `preparing` status it says "Confirm readiness" and is disabled until `allPrepared` (every item checked); otherwise it opens the assign-captain sheet.
- `confirmReadiness` guards on both `isPreparing` AND `allPrepared`, and uses the global `loadingService` overlay (not in-state loading).
- Every successful action funnels through `_applyOrder`, which **rebuilds the entire state from the returned order**. If the returned order has no UI status (e.g. it was rejected/cancelled elsewhere meanwhile), the screen flips to an error state showing the raw `order.state`.
- Item/captain names are localized at mapping time via `_isArabic()` reading the stored language; `totalHalalas` is backend-authoritative and never recomputed client-side.
- Captain assignment is decoupled: `AssignCaptainBottomSheet` returns the updated `CashierOrder`, and the details view calls `applyAssigned(order)` to refresh itself.
- `AssignCaptainState.displayState` returns `empty` when a search query matches nothing even though the fetch succeeded; filtering preserves original indices so selection stays stable across queries.
- Note: `reject` and `mark_item_unavailable` endpoints exist in the repository/API but are **not** wired into either of these controllers yet.

---

## 🔗 Related

- API endpoints: `GET /cashier/orders/{id}`, `PATCH /cashier/orders/{id}/items/{itemId}/prepared`, `POST /cashier/orders/{id}/confirm-ready`, `GET /cashier/orders/{id}/available-captains`, `POST /cashier/orders/{id}/assign-captain` (full schema in Postman)
- Linked features: `cashier_home`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
