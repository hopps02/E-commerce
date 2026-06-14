# 📌 Favorites

> Lets a customer save products and see them all in one grid, with a heart toggle that works app-wide.

---

## 🎯 Purpose

Gives the customer a single place to view every favorited product and to add/remove favorites from any screen (home, search, product details, favorites). One shared membership set keeps every heart icon in the app visually consistent without re-fetching.

---

## 🧱 Key Classes

- `FavoritesView` — main screen (grid of favorited `BranchProduct`s)
- `FavoritesNotifier` / `favoritesController` — handles `load`, `toggle`, `seedFrom`, `clear`
- `getFavoritesUseCase` / `addFavoriteUseCase` / `removeFavoriteUseCase` — load list, add, remove
- `BranchProduct` (`catalog_response.dart`) — backend contract (carries `is_favorite` per item)

---

## 🔁 Flow (brief)

UI → FavoritesNotifier → UseCase → RepositoryImpl → CustomerApi → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- `toggle()` is **optimistic**: it flips `ids` + `products` immediately, then calls add/remove. On failure it **rolls back** the membership and shows a snackbar.
- The controller is **app-lifetime** (not autoDispose). `ids` is the canonical membership every heart in the app reads via `contains(id)`.
- `seedFrom(products)` seeds membership from any freshly loaded list (using each item's `is_favorite`) so hearts are correct without a dedicated favorites fetch.
- `FavoritesManager` in `app/utils/favorite_observer.dart` is a separate legacy observer singleton (providers vs products maps); the Riverpod controller is the live source of truth — don't confuse the two.
- Empty state reuses the error slot: when `reqState == empty/error` and message is blank, the view shows the `no_favorites` translation.

---

## 🔗 Related

- API endpoints: `GET /mobile/favorites`, `POST /mobile/favorites/{id}`, `DELETE /mobile/favorites/{id}` (full schema in Postman)
- Linked features: `cart`, `product_details`, `user_home`, `search`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
