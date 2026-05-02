# 🖥️ Search Screens

---

## 📱 SearchView

**Purpose:**
Master search scaffold. Manages auto-focus behavior and renders the search bar plus results/history area.

---

### 🧩 Components

* `SearchBarSection` → Text field with clear button and back navigation
* `SearchResultsGrid` → Responsive product grid (shown when results available)
* Recent searches list (shown when idle)
* `FastStateRender` → Manages loading / empty / error states

---

### 🔗 State Management

* Connected to `SearchController` (`AutoDisposeNotifier`)
* Observes: search string, `ReqState` (idle / loading / success / empty / error), results list

---

### ⚡ Actions

* Text input → `SearchController.onSearchChanged(text)` (debounced)
* Clear button → clears text → resets to idle state
* Back button → `Navigator.pop()`
* Product card tap → navigate to `ProductDetailsView`

---

### ⚠️ States

* **Idle** → Recent search history displayed
* **Loading** → Skeleton or spinner shown
* **Success** → `SearchResultsGrid` rendered
* **Empty** → `FastStateRender` empty state (no results found)
* **Error** → `FastStateRender` error state
