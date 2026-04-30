# Sections (Categories) Feature

This document details the implementation of the Sections (Categories) module, adhering to the project's **MVVM + Clean Architecture** guidelines.

## 1. Feature Overview
The Sections module serves as the primary directory for the e-commerce platform. It provides a structured, grid-based visual layout of all major product categories, allowing users to drill down into specific domains (e.g., "Fresh Produce", "Snacks").

## 2. User Flow
1. **Entry Point**: The user accesses this view by tapping "View All" on the Home screen's categories strip or via persistent bottom navigation.
2. **Category Selection**: The user is presented with a visually appealing `SliverGrid` of category cards.
3. **Navigation**: Tapping a section card pushes the `ProductsView`, passing the specific `sectionId` as routing arguments to fetch the relevant catalog.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `SectionsView`: Utilizes `CustomScrollView` and `SliverGrid` to render categories dynamically. Wrapped in `FastStateRender` to automatically manage loading, error, and empty states.
    - `SectionCard`: A reusable widget displaying the category image, localized title, and an optional visual indicator.
- **ViewModel (Riverpod)**: 
    - `SectionsController`: A notifier (or provider) responsible for fetching the master list of sections and maintaining the `ReqState`.

### Domain & Data
- **Repository**: `SectionsRepository.getAllSections()`
- **Caching Strategy**: Given that root categories change infrequently, this data is an excellent candidate for local caching or Riverpod's `keepAlive` caching to prevent redundant network requests upon rapid tab switching.

## 4. UI/UX Considerations
- **Grid Responsiveness**: Utilizes `SliverGridDelegateWithFixedCrossAxisCount` adjusted dynamically via `flutter_screenutil` constraints to ensure the cards do not stretch unpleasantly on larger devices or tablets.
- **Image Handling**: `CustomCachedImage` is used heavily here to provide localized loading skeletons and prevent visual popping when images are downloaded.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
