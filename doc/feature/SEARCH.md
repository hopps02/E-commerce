# Search Feature

This document outlines the implementation of the Search functionality, an essential discovery mechanism built upon the **MVVM + Clean Architecture** structure.

## 1. Feature Overview
The Search module empowers users to find specific products rapidly. It features an interactive, focus-driven text input, real-time debounce querying, historical search persistence, and a responsive grid layout for results.

## 2. User Flow
1. **Activation**: Entering the `SearchView` automatically focuses the search text field, bringing up the keyboard.
2. **Idle State**: Before typing, the user is presented with a "Recent Searches" list (and potentially suggested categories).
3. **Querying**: As the user types, a debounce mechanism (e.g., 500ms) pauses network requests to prevent server flooding.
4. **Result Rendering**: Once data is retrieved, the UI replaces the history view with a `SliverGrid` of `ProductCard` components.
5. **Empty State**: If no results match the query, a localized `NoResultsFoundWidget` (via `FastStateRender`) is displayed.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `SearchView`: The master scaffold. Routes focus node logic to the `SearchBarSection`.
    - `SearchBarSection`: Contains the text field, clear button, and back navigation.
    - `SearchResultsGrid`: A responsive grid adapting to screen width via `ScreenUtil`.
- **ViewModel (Riverpod)**: 
    - `SearchController`: An `AutoDisposeNotifier` that holds the search string, manages the debounce timer, and coordinates the state transition between `ReqState.idle` (history), `ReqState.loading`, and `ReqState.success` (results).

### Domain & Data
- **Local Persistence**: `SearchHistoryRepository` interfaces with shared preferences or a local database (Hive/Isar) to save and retrieve recent search queries.
- **Remote Data**: `ProductsRepository.searchProducts(String query)` sends the validated string to the backend indexing service.

## 4. Architectural Decisions
- **Debouncing Strategy**: Handled entirely at the ViewModel layer to keep the View purely declarative. The View simply calls `controller.onSearchChanged(text)`, and the ViewModel internally handles the `Timer`.
- **Keyboard Management**: Built-in mechanisms (`FocusNode` and `GestureDetector` on the background) ensure the keyboard automatically dismisses when the user begins scrolling through results, maximizing screen real estate.
- **Routing**: Search is intentionally kept as a separate route rather than an overlay to preserve navigation history and allow deep-linking directly into search queries.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
