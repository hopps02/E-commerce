# 🔄 Home Tab (TapHomeView) Flow

---

## 👤 User Flow

1. User lands on `TapHomeView` (default tab after login, or returns from another tab)
2. Per-section loading skeletons shown while data fetches in parallel
3. Result per section:

   * ✅ Banners loaded → `HomeCarousel` animates and auto-scrolls
   * ✅ Categories loaded → `SectionsList` horizontal scroll rendered
   * ✅ Featured products loaded → `FeaturedProductsGrid` rendered
   * ❌ Any section fails → that section shows its own error/empty state independently

4. User taps **search bar** → navigate to `SearchView`
5. User taps **"View All"** on categories → navigate to `SectionsView`
6. User taps a **product card** → navigate to `ProductDetailsView`
7. User **pull-to-refresh** → all providers invalidated → parallel re-fetch from step 2

---

## 🔁 System Flow

TapHomeView → TapHomeController → parallel:
  ├── BannersProvider → HomeRepository.getBanners() → API
  ├── SectionsProvider → SectionsRepository.getSections() → API
  └── FeaturedProductsProvider → ProductsRepository.getFeaturedProducts() → API

---

## ⏱️ Special Logic

* **`NestedScrollView`**: `HomeTapAppBar` collapses on scroll; `ContentBody` scrolls independently
* **`AutomaticKeepAliveClientMixin`**: Scroll position and state preserved when switching tabs
* **Independent section failures**: Each section uses its own `FastStateRender` — one failure does not affect others

---

## ⚠️ Edge Cases

* [ ] Banners fail to load → banners section shows error/is hidden; categories and products still render
* [ ] All sections fail → each shows its own error widget; page is not blank
* [ ] Pull-to-refresh while a section is still loading → providers re-invalidated, re-fetch restarts
* [ ] User switches tab mid-fetch and returns → fetch continues in background; state is preserved

---

## 📍 Navigation

* This tab is active when `BottomNavigationController.index == 0`
* **Outbound navigation from this tab:**
  * `SearchView` ← search bar tap
  * `SectionsView` ← "View All" tap on categories
  * `ProductDetailsView` ← product card tap
