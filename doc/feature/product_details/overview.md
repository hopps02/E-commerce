# 📌 Product Details

---

## 📖 Overview

A critical conversion point in the application. Provides a deep dive into a specific item's metadata: high-fidelity image gallery, dynamic weight variants with synchronized pricing, detailed description, and cart integration.

---

## 🎯 Responsibilities

- Fetch and display a single product by ID
- Render image gallery with pagination dots and favorite toggle
- Allow variant (weight) selection with real-time price recalculation
- Support "Add to Cart" / quantity adjustment for the selected variant
- Navigate to `CartView` via the "View Cart" icon

---

## 🧠 System Behavior / Approach

The `ProductDetailsController` is an `AutoDisposeNotifier` tied to the screen lifecycle — it auto-disposes when the user navigates away, freeing resources.

Changing the selected weight chip updates `selectedWeightIndex` in the controller, which triggers a derived computation of `currentPrice` without a new API call.

The bottom bar is always visible (fixed-position) to maintain persistent access to the primary CTA regardless of scroll depth.

---

## 🔁 Data Flow

1. User arrives via `ProductDetailsViewArgs` (containing `productId`)
2. `ProductDetailsController` calls `GetProductDetailsUseCase`
3. `GetProductDetailsUseCase` calls `ProductsRepository.getProductById(id)`
4. `FastStateRender` shows loading
5. On success → full product entity displayed
6. User selects weight chip → `selectedWeightIndex` updated → `currentPrice` recalculated
7. User taps "Add to Cart" → `CartController` updated globally
8. User taps "View Cart" icon → navigate to `CartView`

---

## 🧱 Architecture Summary

### 📱 Presentation

- `ProductDetailsView` → Scrollable layout with fixed bottom bar; wrapped in `FastStateRender`
- `ProductImageSlider` → Image carousel with pagination dots and favorite toggle
- `ProductInfoSection` → Localized title, current/discounted price, availability
- `ProductWeightSelector` → Horizontal selectable chips for variants
- `ProductDetailsBottomBar` → Fixed CTA bar (price + add to cart)

- `ProductDetailsController` → `AutoDisposeNotifier`; fetches product, manages `selectedWeightIndex`, derives `currentPrice`

---

### 🧠 Domain

- `GetProductDetailsUseCase` → Validates `productId` and calls repository

---

### 💾 Data

- `ProductsRepository.getProductById(String id)` → Fetches product and maps JSON to `ProductEntity`

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
