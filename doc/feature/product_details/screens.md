# 🖥️ Product Details Screens

---

## 📱 ProductDetailsView

**Purpose:**
Deep-dive screen for a single product. Presents image gallery, variant selection, pricing, and cart integration with a persistent bottom action bar.

---

### 🧩 Components

* `ProductImageSlider` → Image carousel with pagination dots and favorite toggle
* `ProductInfoSection` → Localized title, current price, discounted price, availability status
* `ProductWeightSelector` → Horizontal chips for weight/variant selection
* `ProductDetailsBottomBar` → Fixed bottom bar: current price + "Add to Cart" CTA + "View Cart" icon
* `FastStateRender` → Manages loading / error states

---

### 🔗 State Management

* Connected to `ProductDetailsController` (`AutoDisposeNotifier`)
* Observes: `ReqState`, `ProductEntity`, `selectedWeightIndex`, `currentPrice`

---

### ⚡ Actions

* Weight chip tap → `controller.selectWeight(index)` → `currentPrice` recalculated
* "Add to Cart" button → `CartController.addItem()` (global)
* "View Cart" icon → navigate to `CartView`
* Image swipe → local `PageController` state

---

### ⚠️ States

* **Loading** (skeleton while product fetches)
* **Success** (full product details displayed)
* **Error** (fetch failure — error widget via `FastStateRender`)
* **Out of Stock** (CTA disabled — availability shown in `ProductInfoSection`)
