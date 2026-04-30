# Home Feature

This document outlines the implementation of the Home screen, serving as the central hub of the Jar application, built upon the **MVVM + Clean Architecture** paradigm.

## 1. Feature Overview
The Home module is the initial landing point post-authentication. It aggregates multiple horizontal and vertical content streams—including promotional carousels, categorized sections, and featured products—into a unified, responsive scrollable interface.

## 2. User Flow
1. **Initialization**: The user lands on the Home screen. A global loading state is displayed while parallel requests fetch promotional banners, categories, and top products.
2. **Navigation Hub**: 
    - Tapping the search bar transitions the user to the dedicated `SearchView`.
    - Tapping "View All" on categories navigates to the `SectionsView`.
    - Tapping individual items routes to `ProductDetailsView` or `ProductsView` (by category).
3. **Pull-to-Refresh**: Swiping down triggers the `SmartRefresher`, invalidating the providers and refetching the latest catalog data from the backend.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `HomeView`: The root screen utilizing a `SmartRefresher` wrapped around a `SingleChildScrollView`.
    - `SearchBarSection`: A read-only representation of a search bar that acts as a router to the actual search domain.
    - `HomeCarousel`: An auto-scrolling page view for promotional banners.
    - `SectionsList`: A horizontal list of main categories.
    - `FeaturedProductsGrid`: A staggered or horizontal grid for top-selling items (`ProductCard`).
- **ViewModel (Riverpod)**: 
    - `HomeController`: Coordinates multiple asynchronous data streams. In a complex home screen, this often aggregates states from `BannersProvider`, `SectionsProvider`, and `FeaturedProductsProvider` to render a unified UI state.

### Domain & Data
- **Repositories**: 
    - `HomeRepository.getBanners()`
    - `SectionsRepository.getSections()`
    - `ProductsRepository.getFeaturedProducts()`
- **Concurrency**: Relies heavily on Riverpod's asynchronous capabilities (`AsyncValue.guard`) to handle partial failures gracefully without breaking the entire Home UI.

## 4. UI/UX Considerations
- **Component Reusability**: The `ProductCard` widget is utilized heavily here and is designed to adapt its constraints (`fitForGridList`) based on its parent container.
- **Status Bar Integration**: Uses `context.topSafeAreaPadding` to ensure content beautifully slides under a transparent status bar.
- **Error Boundaries**: Failed sections (e.g., banners failing to load) should fail independently, replacing themselves with localized error or empty states rather than crashing the entire view.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
