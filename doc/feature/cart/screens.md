# 🖥️ Shopping Cart Screens

---

## 📱 CartView

**Purpose:**
Primary cart screen displaying all selected items, price breakdown, and checkout action.

---

### 🧩 Components

* `CartAppBar` → Standardized app bar with cart title and item count
* `CartItemCard` → Modular item card (image, name, weight, quantity controls, price, remove)
* `CartSummaryBottomBar` → Fixed bottom bar with subtotal, shipping, discount, total, and checkout CTA
* `FastStateRender` → Orchestrates loading / error / empty states

---

### 🔗 State Management

* Connected to `CartController` (`Notifier<CartState>`)
* Observes: `CartState` (item list, total price, loading/error flags)

---

### ⚡ Actions

* Quantity `+` / `-` buttons → local `setState` (optimistic) → debounced `CartController.updateQuantity()`
* Trash icon → `CartController.removeItem()`
* Checkout button → *(planned)* navigate to checkout

---

### ⚠️ States

* Loading (skeleton or spinner)
* Success (item list rendered)
* Empty (Lottie animation + localized "cart is empty" message via `FastStateRender`)
* Error (error widget via `FastStateRender`)

---

## 📱 CartItemCard

**Purpose:**
Reusable card representing a single cart item with quantity controls and removal action.

---

### 🧩 Components

* Product image (`CustomCachedImage`)
* Product name and weight label
* Quantity stepper (`+` / `-` with local state)
* Item price
* Remove button (trash icon)

---

### 🔗 State Management

* Local `setState` for immediate quantity display
* Debounce timer delays propagation to `CartController`

---

### ⚡ Actions

* `+` button → increments local quantity → debounce → `CartController.updateQuantity()`
* `-` button → decrements local quantity → debounce → `CartController.updateQuantity()`
* Trash icon → `CartController.removeItem()`

---

### ⚠️ States

* Default (item displayed)
* Updating (debounce in progress — no visual change, silent sync)
