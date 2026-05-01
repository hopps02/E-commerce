# 🔄 Product Details Flow

---

## 👤 User Flow

1. User taps a product card (from `ProductsView`, `HomeView`, or `SearchView`)
2. App navigates to `ProductDetailsView` passing `productId` via `ProductDetailsViewArgs`
3. Loading state shown while product is fetched
4. Result:

   * ✅ Product loaded → full detail view rendered
   * ❌ Error → error state shown
5. User swipes image gallery to view additional product images
6. User selects a weight/variant chip:

   * Price updates immediately (local controller state)
7. User taps "Add to Cart":

   * `CartController` updated globally
   * Button transitions to quantity stepper (if already in cart)
8. User taps "View Cart" icon → navigate to `CartView`

---

## 🔁 System Flow

UI → ProductDetailsController → GetProductDetailsUseCase → ProductsRepository → API → Response → UI

(Weight selection) → UI → controller.selectWeight(index) → derived currentPrice → UI

---

## ⏱️ Special Logic

* **Derived price**: `currentPrice` is computed from `selectedWeightIndex` without an additional API call
* **AutoDispose**: Controller disposes on screen exit, freeing resources

---

## ⚠️ Edge Cases

* [ ] Invalid or missing `productId` → error state
* [ ] Product with no weight variants → hide weight selector
* [ ] Network failure → error state with retry
* [ ] Product out of stock → disable "Add to Cart" CTA

---

## 📍 Navigation

* From → `ProductsView` / `HomeView` / `SearchView` (product card tap)
* To → `CartView` (via "View Cart" icon)
* Conditions → "View Cart" navigates regardless of current product state
