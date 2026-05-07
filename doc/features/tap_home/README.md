# 📌 Home Tab (TapHomeView)

> Primary content tab of the Home screen aggregating promotional banners, product categories, and featured products.

---

## 🎯 Purpose

`TapHomeView` provides the main storefront experience for the user. It combines different content types into a unified, scrollable interface with a sticky app bar and independent section loading.

- Display an auto-scrolling banners carousel
- Display a horizontal categories list with a "View All" shortcut
- Display a featured products grid
- Route user to Search, Sections, and ProductDetails screens
- Handle per-section loading / error / empty states independently

---

## 🧱 Key Classes

- `TapHomeView` — main screen (NestedScrollView with sliver header)
- `TapHomeController` — coordinates multiple async data streams
- `HomeCarousel` — auto-scrolling promotional banners PageView
- `SectionsList` — horizontal categories list + "View All" button
- `FeaturedProductsGrid` — grid/horizontal list of ProductCard items

---

## 🔁 Flow (brief)

TapHomeView → TapHomeController → Parallel fetches:
1. BannersProvider → HomeRepository.getBanners()
2. SectionsProvider → SectionsRepository.getSections()
3. FeaturedProductsProvider → ProductsRepository.getFeaturedProducts()

UI renders per-section results independently via FastStateRender.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Independent Failures**: Each section (banners, categories, products) is driven by its own provider. A failure in one section does not crash or block the rest of the page.
- **Sticky AppBar**: Uses `NestedScrollView` to allow the `HomeTapAppBar` to collapse on scroll while `ContentBody` handles the rest.
- **State Preservation**: Uses `AutomaticKeepAliveClientMixin` to preserve scroll position and fetched data when the user switches tabs and returns.

---

## 🔗 Related

- API endpoints: `/banners`, `/sections`, `/products/featured` (Planned)
- Linked features: `SearchView`, `SectionsView`, `ProductDetailsView`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
