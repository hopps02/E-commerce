# Products Listing Feature

This document outlines the implementation of the Products Listing module, which displays items belonging to a specific section/category, built strictly on the **MVVM + Clean Architecture** paradigm.

## 1. Feature Overview
The Products view acts as the primary catalog browsing interface. It receives a `sectionId` and renders a paginated grid of products. It is designed to handle high volumes of items smoothly.

## 2. User Flow
1. **Contextual Entry**: The user navigates here from the `SectionsView` or a specific promotion on the `HomeView`. The view's title dynamically updates to match the selected category.
2. **Browsing**: The user scrolls through a staggered or standard `SliverGrid` of products.
3. **Pagination**: Reaching the bottom of the scroll view triggers a "Load More" action (cursor-based or page-based pagination).
4. **Interaction**: 
    - Quick "Add to Cart" directly from the product card.
    - Tapping the card routes to the deeply-detailed `ProductDetailsView`.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `ProductsView`: Scaffold utilizing `SmartRefresher` for both pull-to-refresh and infinite scrolling (`enablePullUp: true`).
    - `ProductsAppBar`: Context-aware app bar that displays the category name.
    - Grid implementation reusing the core `ProductCard` widget.
- **ViewModel (Riverpod)**: 
    - `ProductsController`: Needs to manage complex state transitions, including:
        - Initial `ReqState.loading` vs. subsequent `ReqState.loadingMore`.
        - Maintaining the aggregate list of `ProductEntity` objects.
        - Updating pagination cursors.

### Domain & Data
- **Repository**: `ProductsRepository.getProductsBySection(String sectionId, int page)`
- **State Composition**: The Riverpod state must track the list of items, the current page, and a boolean flag `hasMoreData` to intelligently disable the SmartRefresher's footer when the end of the catalog is reached.

## 4. Design & Performance Notes
- **Widget Reusability**: The `ProductCard` here is identical to the one on the Home screen but is constrained differently by the Grid delegate.
- **Memory Management**: Images in the list heavily rely on `CachedNetworkImage` (wrapped in `CustomCachedImage`) to prevent `OutOfMemory` exceptions during rapid scrolling.
- **State Encapsulation**: Tapping "Add to Cart" on a `ProductCard` here does not mutate this screen's state. It fires a global event/method on the `CartController`, ensuring the catalog view remains lightweight and solely focused on presentation.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
