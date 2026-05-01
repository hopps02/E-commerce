# 🖥️ Products Listing Screens

---

## 📱 ProductsView

**Purpose:**
Paginated product grid for a specific category/section. Supports pull-to-refresh and infinite scroll.

---

### 🧩 Components

* `ProductsAppBar` → Context-aware app bar with category name
* `SmartRefresher` → Enables pull-to-refresh and load-more footer
* `SliverGrid` of `ProductCard` → Product grid adapting to screen width
* `FastStateRender` → Manages loading / error / empty states
* `CustomCachedImage` → Image loading with skeleton and caching

---

### 🔗 State Management

* Connected to `ProductsController`
* Observes: `ReqState` (loading / loadingMore / success / empty / error), product list, `hasMoreData`, pagination cursor

---

### ⚡ Actions

* Product card tap → navigate to `ProductDetailsView`
* "Add to Cart" on card → `CartController` updated (global, no local state change)
* Pull-to-refresh → reset and re-fetch from page 0
* Scroll to bottom → `loadingMore` state → next page fetched

---

### ⚠️ States

* **Loading** (initial fetch — full screen skeleton)
* **Loading More** (`SmartRefresher` footer spinner)
* **Success** (product grid rendered)
* **Empty** (no products in this section)
* **Error** (network/server failure)
