# 🔄 Sections (Categories) Flow

---

## 👤 User Flow

1. User taps "View All" on `HomeView` categories strip, or navigates via bottom navigation
2. `SectionsView` opens
3. Loading state shown while categories fetch
4. Result:

   * ✅ Categories loaded → grid of `SectionCard` rendered
   * ❌ Empty → empty state shown
   * ❌ Error → error state shown
5. User taps a `SectionCard`
6. App navigates to `ProductsView` passing the selected `sectionId`

---

## 🔁 System Flow

UI → SectionsController → SectionsRepository → API → Response → UI

---

## ⏱️ Special Logic

* **Riverpod `keepAlive`**: Section data should be cached to avoid re-fetching on tab switch

---

## ⚠️ Edge Cases

* [ ] Empty categories list from API → empty state
* [ ] Network failure → error state with retry option
* [ ] Rapid tab switching → cached data should prevent redundant requests

---

## 📍 Navigation

* From → `HomeView` ("View All" tap) or bottom navigation tab
* To → `ProductsView` (with `sectionId` argument)
* Conditions → Navigation triggered on `SectionCard` tap
