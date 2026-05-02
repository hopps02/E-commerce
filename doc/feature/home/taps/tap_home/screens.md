# 🖥️ Home Tab Screens

---

## 📱 TapHomeView

**Purpose:**
The primary content tab (Tab 0). Aggregates banners, categories, and featured products in a `NestedScrollView` with a sticky app bar.

---

### 🧩 Components

* `HomeTapAppBar` → Sticky sliver app bar (search bar + logo/branding); collapses on scroll
* `ContentBody` → Scrollable content wrapper containing all sections

---

### 🔗 State Management

* Connected to `TapHomeController`
* Each content section observes its own async provider independently

---

### ⚡ Actions

* Search bar tap → navigate to `SearchView`
* Pull-to-refresh → invalidate all providers → re-fetch

---

### ⚠️ States

* Per-section independent states (see sub-sections below)

---

---

## 📱 HomeCarousel *(inside ContentBody)*

**Purpose:**
Auto-scrolling `PageView` of promotional banners at the top of the Home tab.

---

### 🧩 Components

* `PageView` with auto-scroll timer
* Pagination dots indicator
* `CustomCachedImage` per banner

---

### 🔗 State Management

* Observes: `BannersProvider` (`AsyncValue<List<BannerEntity>>`)

---

### ⚡ Actions

* Banner tap → *(planned)* route to promotion target (product / section / URL)

---

### ⚠️ States

* Loading (skeleton placeholder)
* Success (carousel animating)
* Error (section hidden or error widget)
* Empty (no banners returned)

---

---

## 📱 SectionsList *(inside ContentBody)*

**Purpose:**
Horizontal scrollable list of main product categories with a "View All" shortcut.

---

### 🧩 Components

* `ListView` (horizontal) of `SectionCard` items
* "View All" button

---

### 🔗 State Management

* Observes: `SectionsProvider` (`AsyncValue<List<SectionEntity>>`)

---

### ⚡ Actions

* Category card tap → navigate to `ProductsView` with `sectionId`
* "View All" tap → navigate to `SectionsView`

---

### ⚠️ States

* Loading (horizontal skeleton)
* Success (categories rendered)
* Error (error widget for this section only)
* Empty (no categories returned)

---

---

## 📱 FeaturedProductsGrid *(inside ContentBody)*

**Purpose:**
Grid or horizontal list of top-selling / featured products using the shared `ProductCard` widget.

---

### 🧩 Components

* `GridView` or `ListView` (horizontal) of `ProductCard` widgets
* `CustomCachedImage` for product images

---

### 🔗 State Management

* Observes: `FeaturedProductsProvider` (`AsyncValue<List<ProductEntity>>`)

---

### ⚡ Actions

* Product card tap → navigate to `ProductDetailsView`
* "Add to Cart" on card → `CartController.addItem()` (global, no local state change)

---

### ⚠️ States

* Loading (grid skeleton)
* Success (products rendered)
* Error (error widget for this section only)
* Empty (no featured products)
