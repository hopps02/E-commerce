# 🖥️ Sections Screens

---

## 📱 SectionsView

**Purpose:**
Grid-based category directory allowing users to browse and select a product category to explore.

---

### 🧩 Components

* `CustomScrollView` + `SliverGrid` → dynamic category grid
* `SectionCard` → Category card (image, localized title, optional indicator)
* `CustomCachedImage` → Image loading with skeleton and caching
* `FastStateRender` → Manages loading / error / empty states

---

### 🔗 State Management

* Connected to `SectionsController`
* Observes: `ReqState`, sections list

---

### ⚡ Actions

* `SectionCard` tap → navigate to `ProductsView` with `sectionId`

---

### ⚠️ States

* Loading (skeleton grid)
* Success (categories rendered)
* Empty (no categories available)
* Error (network/server failure)
