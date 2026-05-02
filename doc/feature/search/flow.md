# 🔄 Search Flow

---

## 👤 User Flow

1. User taps search bar on `HomeView` (or navigates to `SearchView`)
2. Text field auto-focuses → keyboard appears
3. **Idle state**: User sees recent search history
4. User types a query:

   * Debounce waits 500ms after last keystroke
   * API request fires
5. Result:

   * ✅ Results found → `SearchResultsGrid` shown
   * ❌ No results → empty state (`FastStateRender`)
   * ❌ Network failure → error state
6. User taps a product → navigates to `ProductDetailsView`
7. User clears text → returns to idle state (history shown)
8. User taps back → returns to previous screen

---

## 🔁 System Flow

UI (text input) → SearchController.onSearchChanged() → debounce Timer → ProductsRepository → API → Response → UI

---

## ⏱️ Special Logic

* **Debounce (500ms)**: Timer is reset on every keystroke; request only fires after 500ms of idle
* **Auto-focus**: `FocusNode` is requested in `initState` to immediately open keyboard
* **Keyboard dismissal**: `GestureDetector` on background dismisses keyboard on scroll

---

## ⚠️ Edge Cases

* [ ] Empty query submitted → should not trigger API call
* [ ] Network failure during search → show error state
* [ ] User types very fast → only last debounced value is sent
* [ ] No search results → empty state with "no results found" message

---

## 📍 Navigation

* From → `HomeView` (search bar tap)
* To → `ProductDetailsView` (on product tap)
* Conditions → Navigation to product requires a valid product selection
