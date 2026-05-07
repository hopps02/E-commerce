# 📌 Product Details

> Deep dive into product metadata including image gallery, weight variants, and cart integration.

---

## 🎯 Purpose

The `ProductDetailsView` is the primary conversion point where users explore specific item details. It handles complex variant logic (such as weight-based pricing) and provides an immersive visual experience.

- Fetch and display a single product's full entity by ID
- Render an image gallery with pagination dots and a favorite toggle
- Support variant (weight) selection with real-time price recalculation
- Enable "Add to Cart" and quantity adjustment for the specific variant
- Provide quick navigation to the shopping cart

---

## 🧱 Key Classes

- `ProductDetailsView` — scrollable layout using FastStateRender and a fixed bottom bar
- `ProductDetailsController` — AutoDisposeNotifier managing data fetching and variant selection
- `ProductImageSlider` — paginated carousel for product images
- `ProductWeightSelector` — horizontal chip-based variant selector
- `ProductDetailsBottomBar` — fixed-position CTA bar containing the price and Add to Cart button

---

## 🔁 Flow (brief)

User taps product → `ProductDetailsView(id)` → `ProductDetailsController` calls `ProductsRepository.getProductById(id)`.

Success → UI renders. User selects weight → `currentPrice` recalculates locally → UI updates.

---

## ⚠️ Gotchas / Non-obvious behavior

- **Auto-Dispose**: The controller is tied to the screen lifecycle via `AutoDispose`. It automatically clears its state and cancels pending tasks when the user navigates away.
- **Local Price Calculation**: Selecting a different weight variant recalculates the displayed price instantly using local entity data. No network request is required for variant switching.
- **Fixed Accessibility**: The bottom interaction bar is independent of the scroll view, ensuring the primary "Add to Cart" action is always within reach.

---

## 🔗 Related

- API endpoints: `GET /products/{id}` (Planned)
- Linked features: `ProductsListing`, `CartView`, `Favorites`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
