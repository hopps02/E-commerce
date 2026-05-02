# 🔄 Products Listing Flow

---

## 👤 User Flow

1. User taps a category in `SectionsView` (or a promotion on `HomeView`)
2. `ProductsView` opens with the category name in the app bar
3. Loading state shown while page 0 is fetched
4. Result:

   * ✅ Products loaded → `SliverGrid` rendered
   * ❌ Empty → empty state shown
   * ❌ Error → error state shown
5. User scrolls to bottom → "Load More" footer fires → next page loaded
6. User pull-to-refresh → resets and re-fetches from page 0
7. User taps product card → navigates to `ProductDetailsView`
8. User taps "Add to Cart" on product card → `CartController` updated globally

---

## 🔁 System Flow

UI → ProductsController → ProductsRepository → API → Response → UI (aggregate list updated)

---

## ⏱️ Special Logic

* **Pagination**: Cursor/page-based. `hasMoreData` flag disables `SmartRefresher` footer when end is reached.
* **State transitions**: Initial `ReqState.loading` vs subsequent `ReqState.loadingMore` must be handled distinctly.

---

## ⚠️ Edge Cases

* [ ] Empty product list for a section → empty state
* [ ] Network failure during initial load → error state with retry
* [ ] Network failure during pagination → footer shows error; list preserved
* [ ] `hasMoreData = false` → footer permanently disabled

---

## 📍 Navigation

* From → `SectionsView` (category tap) or `HomeView` (promotion tap)
* To → `ProductDetailsView` (on product card tap)
* Conditions → Always navigates on product tap regardless of cart state
