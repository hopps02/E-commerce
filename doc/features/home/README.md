# 📌 Home

> Root navigation shell of the authenticated zone.

---

## 🎯 Purpose

The `HomeView` serves as the container for the authenticated app experience. It manages the bottom navigation bar and handles switching between main feature tabs while preserving their state.

- Initialize and render the bottom navigation shell
- Host all tab views inside a `PageSlider` (`PageView`)
- Manage the selected tab index via `BottomNavigationController`
- Preserve tab state across switches using `AutomaticKeepAliveClientMixin`

---

## 🧱 Key Classes

- `HomeView` — main screen (StatefulWidget)
- `BottomNavigationController` — manages and exposes the currently selected tab index
- `PageSlider` — `PageView` hosting all tab views
- `BottomNavigation` — custom floating bottom nav bar

---

## 🔁 Flow (brief)

AuthSuccessView → HomeView → PageSlider (PageView) → [Tab 0 active by default]

User taps bottom nav → `BottomNavigationController.setIndex(n)` → `PageSlider` animates to tab `n`.

---

## ⚠️ Gotchas / Non-obvious behavior

- **State Preservation**: All tab views use `AutomaticKeepAliveClientMixin` (keepAlive: true). This prevents tabs from rebuilding or re-fetching data when the user switches away and returns.
- **Custom Scaffold**: Uses a `Stack`-based layout with `GradientBackground` to create a floating nav bar effect, bypassing the standard `Scaffold.bottomNavigationBar`.

---

## 🔗 Related

- API endpoints: None (shell level).
- Linked features: `tap_home`, `cart`, `my_orders`, `profile`.

---

_Last updated: 2026-05-07 · Owner: Antigravity_
