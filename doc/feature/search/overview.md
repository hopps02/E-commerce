# 📌 Search

---

## 📖 Overview

Empowers users to find specific products rapidly using an interactive text input with real-time debounce querying, historical search persistence, and a responsive grid layout for results.

---

## 🎯 Responsibilities

- Accept user text input and debounce network requests (500ms)
- Display recent search history when idle
- Show a product grid when results are returned
- Handle empty state when no results match the query
- Persist and retrieve search history locally

---

## 🧠 System Behavior / Approach

The search field auto-focuses on screen mount, immediately bringing up the keyboard. Before any typing, the user sees their recent search history.

Debouncing is handled entirely at the ViewModel layer — the View only calls `controller.onSearchChanged(text)` and remains purely declarative. The ViewModel manages the internal `Timer` to coalesce rapid keystrokes into a single network request.

A `FocusNode` + `GestureDetector` on the background ensures the keyboard dismisses automatically when the user scrolls through results, maximizing screen real estate.

Search is a dedicated route (not an overlay) to preserve navigation history and enable deep-linking.

---

## 🔁 Data Flow

1. User opens `SearchView` → text field auto-focuses
2. User types → `SearchController.onSearchChanged()` → debounce timer resets
3. After 500ms of idle → `ProductsRepository.searchProducts(query)` triggered
4. Results returned → `ReqState.success` → `SearchResultsGrid` rendered
5. No results → `FastStateRender` shows empty state
6. User taps result → navigated to `ProductDetailsView`

---

## 🧱 Architecture Summary

### 📱 Presentation

- `SearchView` → Master scaffold; manages focus node routing to `SearchBarSection`
- `SearchBarSection` → Text field, clear button, back navigation
- `SearchResultsGrid` → Responsive grid of `ProductCard` components

- `SearchController` → `AutoDisposeNotifier` managing search string, debounce timer, and state transitions between idle / loading / success / empty

---

### 🧠 Domain

- *(Planned)* `SearchProductsUseCase` → Validates query and calls repository

---

### 💾 Data

- `SearchHistoryRepository` → SharedPreferences or Hive for recent searches
- `ProductsRepository.searchProducts(String query)` → Remote search endpoint

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
