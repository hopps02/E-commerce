# 📌 Products Listing

> Primary catalog browsing interface rendering a paginated grid of products for a specific category.

---

## 🎯 Purpose

The `ProductsView` allows users to browse the full catalog of a specific section or category. It handles large datasets through efficient pagination and provides quick interaction points for purchasing.

- Display products filtered by a specific `sectionId`
- Support both pull-to-refresh and infinite scroll (load more) pagination
- Allow quick "Add to Cart" directly from the product grid
- Route the user to detailed product information on tap

---

## 🧱 Key Classes

- `ProductsView` — grid screen implementing `SmartRefresher` for pagination
- `ProductsController` — Notifier managing the aggregate list, current page, and `ReqState`
- `ProductCard` — shared component for visual product representation
- `ProductsRepository` — data source for paginated product lists

---

## 🔁 Flow (brief)

User selects category → `ProductsView(sectionId)` → `ProductsController` fetches page 0.

Scrolling to bottom → `ProductsController` fetches next page → Items appended to list.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Pagination Guard**: The controller tracks a `hasMoreData` boolean. When an API response returns fewer items than the page size, this is set to false to prevent further "load more" triggers.
- **External State Dependency**: Tapping "Add to Cart" on a product card interacts directly with the global `CartController`. The `ProductsView` itself does not manage cart state.
- **Performance**: High-density grids use `CustomCachedImage` to prevent memory spikes when scrolling through hundreds of product images.

---

## 🔗 Related

- API endpoints: `GET /products?sectionId={id}&page={n}` (Planned)
- Linked features: `SectionsView`, `ProductDetailsView`, `CartView`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
