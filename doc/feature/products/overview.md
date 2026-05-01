# 📌 Products Listing

---

## 📖 Overview

The primary catalog browsing interface for a specific section/category. Receives a `sectionId` and renders a paginated grid of products.

---

## 🎯 Responsibilities

- Receive `sectionId` from routing arguments and display its product list
- Render a paginated product grid with `SmartRefresher`
- Support pull-to-refresh and infinite scroll (load more)
- Allow quick "Add to Cart" from the product card
- Navigate to `ProductDetailsView` on product tap

---

## 🧠 System Behavior / Approach

The `ProductsView` uses `SmartRefresher` with `enablePullUp: true` to support both pull-to-refresh and infinite scroll pagination. The `ProductsController` tracks the current page, the full aggregate list of `ProductEntity` objects, and a `hasMoreData` boolean to intelligently disable the footer when the catalog end is reached.

"Add to Cart" from a `ProductCard` fires a global event on `CartController`, keeping this screen lightweight and focused purely on catalog presentation.

`CachedNetworkImage` (via `CustomCachedImage`) is used heavily to prevent `OutOfMemory` exceptions during rapid scrolling.

---

## 🔁 Data Flow

1. User arrives at `ProductsView` with `sectionId`
2. `ProductsController` triggers `ProductsRepository.getProductsBySection(sectionId, page: 0)`
3. `ReqState.loading` shown
4. On success → product grid rendered
5. User scrolls to bottom → `ReqState.loadingMore` → next page fetched
6. `hasMoreData = false` → footer disabled
7. User pull-to-refresh → state reset → page 0 re-fetched

---

## 🧱 Architecture Summary

### 📱 Presentation

- `ProductsView` → `SmartRefresher` wrapping `SliverGrid` of `ProductCard` widgets
- `ProductsAppBar` → Context-aware app bar showing the category name

- `ProductsController` → Manages `ReqState`, aggregate product list, pagination cursor, `hasMoreData`

---

### 🧠 Domain

- *(Planned)* `GetProductsBySectionUseCase` → Validates `sectionId` and calls repository

---

### 💾 Data

- `ProductsRepository.getProductsBySection(String sectionId, int page)` → Paginated product list

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
