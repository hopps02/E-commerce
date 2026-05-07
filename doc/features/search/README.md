# 📌 Search

> Real-time product discovery featuring debounced querying, historical search persistence, and responsive results.

---

## 🎯 Purpose

The `SearchView` provides a high-speed path for users to find specific products. It emphasizes responsiveness and ease of use through intelligent input handling and automated state transitions.

- Accept user text input and debounce network requests (500ms) to minimize server load
- Display recent search history when the input field is idle
- Show a responsive product grid when results are returned
- Handle empty states gracefully when no products match the query
- Persist and retrieve the user's search history locally

---

## 🧱 Key Classes

- `SearchView` — primary screen with auto-focus and focus node management
- `SearchController` — AutoDisposeNotifier managing the search query, debounce timer, and state
- `SearchBarSection` — component containing the text field and navigation controls
- `SearchResultsGrid` — grid layout for rendering product result cards

---

## 🔁 Flow (brief)

User opens SearchView → Input auto-focuses.

User types → `SearchController` debounces (500ms) → `ProductsRepository.searchProducts(query)`.

Results arrive → `FastStateRender` displays grid or empty state.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Debounce Timer**: Requests are not sent on every keystroke. The `SearchController` uses a 500ms timer that resets with every character typed, ensuring the API is only called after the user pauses.
- **UX Polish**: The keyboard is automatically dismissed when the user begins scrolling through results, providing more screen space for browsing.
- **Idle State**: When the search field is empty, the view automatically shifts to show the "Search History" section retrieved from local storage.

---

## 🔗 Related

- API endpoints: `GET /products/search?query={q}` (Planned)
- Linked features: `ProductDetailsView`, `HomeView` (via Search icon).

---

_Last updated: 2026-05-07 · Owner: Antigravity_
