# Product Details Feature

This document outlines the implementation of the Product Details module, a critical conversion point in the application governed by the **MVVM + Clean Architecture** pattern.

## 1. Feature Overview
The Product Details screen provides a deep dive into a specific item's metadata. It showcases high-fidelity image galleries, dynamic weight variants with synchronized pricing, detailed descriptions, and fixed action areas for seamless cart integration.

## 2. User Flow
1. **Entry**: The user navigates here by passing a `ProductDetailsViewArgs` (containing the `productId`) via routing.
2. **Variant Selection**: The user interacts with the `ProductWeightSelector`. Changing the weight dynamically recalculates the displayed price.
3. **Cart Integration**: 
    - The bottom bar contains the calculated total price for the selected variant.
    - The "Add to Cart" button (or quantity selector) dispatches an intent to update the user's global cart state.
    - The "View Cart" icon button routes the user directly to the checkout flow (`CartView`).

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `ProductDetailsView`: A scrollable layout terminating in a fixed bottom navigation bar. Wrapped in `FastStateRender`.
    - `ProductImageSlider`: A robust image carousel with pagination dots and a favorite toggle.
    - `ProductInfoSection`: Displays localized title, pricing (current and discounted), and availability status.
    - `ProductWeightSelector`: A horizontal list of selectable chips representing product variants.
    - `ProductDetailsBottomBar`: A fixed-position widget maintaining persistent access to the primary CTA.
- **ViewModel (Riverpod)**: 
    - `ProductDetailsController`: An `AutoDisposeNotifier` tied directly to the lifecycle of the screen. Fetches the product by ID upon initialization.
    - Manages local UI states such as `selectedWeightIndex` and recalculates derived states like `currentPrice`.

### Domain & Data
- **UseCase**: `GetProductDetailsUseCase` validates the ID and requests data from the data layer.
- **Repository**: `ProductsRepository.getProductById(String id)` handles the network request and maps the JSON response into a robust `ProductEntity`.

## 4. Design Highlights
- **Slivers vs SingleChildScrollView**: Utilizes a combination of sticky app bars and standard scrolling lists to keep the image and title prominent while allowing deep exploration of the description.
- **Typography & Localization**: Heavily utilizes dynamic text sizing (`sp`) and localization (`ar.json` / `en.json`) to handle bidirectional text properties efficiently.
- **Visual Dividers**: Systematic use of `ColorM.gray150` and `ColorM.gray300` dividers ensures clear visual hierarchy between distinct informational sections.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
