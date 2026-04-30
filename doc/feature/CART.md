# Shopping Cart Feature

This document outlines the implementation of the Shopping Cart module, adhering to the project's **MVVM + Clean Architecture** and strictly following the Figma design system.

## 1. Feature Overview
The Shopping Cart module provides users with a comprehensive summary of their selected products. It handles real-time quantity mutations, dynamic price calculations (subtotal, shipping, discount, total), and seamless RTL/LTR layout transitions.

## 2. User Flow
1. **Cart Entry**: The user navigates to the Cart from the Product Details bottom bar or Home view.
2. **Item Overview**: The cart renders a list of `CartItemCard` widgets, displaying product details, selected weight, and quantity.
3. **Quantity Mutation**: Users can increment/decrement quantities. The UI updates optimistically via `setState`, while a debounce timer synchronizes the actual state update with the `CartController`.
4. **Item Removal**: Users can remove items completely via the trash icon.
5. **Checkout Intent**: The fixed `CartSummaryBottomBar` maintains constant visibility of the price breakdown and provides the primary CTA for proceeding to checkout.
6. **Empty State**: If all items are removed, a localized empty state with an accompanying Lottie animation (`FastStateRender`) is displayed.

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: 
    - `CartView`: The primary scaffold containing the app bar, a `ListView.separated` of items, and the bottom summary bar. Utilizes `FastStateRender` for robust loading/error/empty state orchestration.
    - `CartItemCard`: A modular, highly reusable component. Implements a local debounce timer to prevent state-management spam during rapid quantity clicks.
    - `CartSummaryBottomBar`: A fixed-position widget that calculates and displays the financial breakdown.
    - `CartAppBar`: A standardized `DefaultAppBar` tailored for the cart.
- **ViewModel (Riverpod)**: 
    - `CartController`: A `Notifier<CartState>` responsible for managing the cart's immutable state (`CartState`). Handles `updateQuantity` and `removeItem` mutations.

### Domain & Data (Pending API Integration)
- **State Handling**: Currently, the `CartController` initializes with mock data for UI testing.
- **Future Integration**: 
    - `CartRepository.getCart()`: To fetch active cart items.
    - `CartRepository.updateItemQuantity()`: To sync debounced quantity changes.
    - `CartRepository.checkout()`: To initiate the payment flow.

## 4. Design & Architecture Highlights
- **Directionality Awareness**: Refactored layout mechanisms away from manual `TextDirection` overrides. The UI composition relies on standard Row/Column ordering, automatically adapting to the global `ar` (RTL) or `en` (LTR) locale context.
- **Design System Fidelity**: Employs `ColorM` constants (e.g., `ColorM.gray150`, `ColorM.primary700`) and `FontWeightM` typography definitions to guarantee 1:1 parity with Figma.
- **Optimistic UI**: Quantity counters update instantly in the widget state, providing immediate tactile feedback before dispatching the asynchronous update to the Riverpod controller.

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*
