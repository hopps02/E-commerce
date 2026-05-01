# 📌 Home Tab (TapHomeView)

---

## 📖 Overview

The primary content tab of the Home screen. Aggregates promotional banners, product categories, and featured products into a unified scrollable interface with a sticky app bar.

---

## 🎯 Responsibilities

- Display an auto-scrolling banners carousel
- Display a horizontal categories list with a "View All" shortcut
- Display a featured products grid
- Route user to Search, Sections, and ProductDetails screens
- Support pull-to-refresh to re-fetch all home content
- Handle per-section loading / error / empty states independently

---

## 🧠 System Behavior / Approach

`TapHomeView` uses a `NestedScrollView` — the `HomeTapAppBar` is a sliver header that collapses on scroll, while `ContentBody` handles the actual content scrolling independently.

Each content section (banners, categories, products) is driven by its own Riverpod provider, so a failure in one section does not crash the rest of the page. `FastStateRender` handles each section's state independently.

`AutomaticKeepAliveClientMixin` ensures the tab state (and scroll position) is preserved when the user switches to another tab and comes back.

---

## 🔁 Data Flow

1. `TapHomeView` mounts (or is kept alive on tab switch)
2. `TapHomeController` triggers parallel data fetches:
   - Banners provider → `HomeRepository.getBanners()`
   - Sections provider → `SectionsRepository.getSections()`
   - Featured products provider → `ProductsRepository.getFeaturedProducts()`
3. Each section shows its own loading skeleton independently
4. On success → each section renders its content
5. On failure → that section shows its error/empty state; others unaffected
6. User pull-to-refresh → all providers invalidated → parallel re-fetch

---

## 🧱 Architecture Summary

### 📱 Presentation

- `TapHomeView` → `NestedScrollView` with sliver app bar + `ContentBody`
- `HomeTapAppBar` → Sticky sliver app bar (search bar + logo/branding)
- `ContentBody` → Scrollable area containing all content sections:
  - `HomeCarousel` → Auto-scrolling promotional banners `PageView`
  - `SectionsList` → Horizontal categories list + "View All" button
  - `FeaturedProductsGrid` → Grid/horizontal list of `ProductCard` items

- `TapHomeController` → Coordinates multiple async data streams

---

### 🧠 Domain

- *(Planned)* `GetBannersUseCase`
- *(Planned)* `GetSectionsUseCase`
- *(Planned)* `GetFeaturedProductsUseCase`

---

### 💾 Data

- *(Planned)* `HomeRepository.getBanners()`
- *(Planned)* `SectionsRepository.getSections()`
- *(Planned)* `ProductsRepository.getFeaturedProducts()`

Uses `fastHandler` / `AsyncValue.guard` for graceful per-section failure handling.

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
* [← Home Shell](../../overview.md)
