# 📌 Home

---

## 📖 Overview

The root navigation shell of the authenticated zone. `HomeView` is not a content screen — it is the container that hosts the bottom navigation bar and manages switching between all main tabs via a `PageView`.

---

## 🎯 Responsibilities

- Initialize and render the bottom navigation shell
- Host all tab views inside a `PageSlider` (`PageView`)
- Manage the selected tab index via `BottomNavigationController`
- Preserve tab state across switches using `AutomaticKeepAliveClientMixin`
- Render the decorative `GradientBackground` overlay

---

## 🧠 System Behavior / Approach

`HomeView` is a pure navigation container. It delegates all content responsibility to its tab views. The `Stack`-based layout layers the `PageSlider`, `GradientBackground`, and `BottomNavigation` to produce the floating nav bar effect without a standard `Scaffold.bottomNavigationBar`.

Tab state is preserved across switches — switching from the Cart tab back to the Home tab does not trigger a rebuild or re-fetch.

---

## 🔁 Data Flow

1. `AuthSuccessView` navigates to `HomeView`
2. `HomeView` initializes 4 `NavigationItem`s and renders `PageSlider`
3. Default selected index = 0 → `TapHomeView` is active
4. User taps a bottom nav item → `BottomNavigationController` updates index → `PageSlider` jumps to that tab

---

## 🧱 Architecture Summary

### 📱 Presentation

- `HomeView` → Root authenticated scaffold (StatefulWidget)
- `PageSlider` → `PageView` hosting all tab views
- `GradientBackground` → Decorative gradient overlay
- `BottomNavigation` → Custom floating bottom nav bar
- `BottomNavigationBar` (widget) → Visual rendering of nav items

- `BottomNavigationController` → Manages and exposes the currently selected tab index

---

### 🧠 Domain

- None — this is a pure navigation shell

---

### 💾 Data

- None — no API calls or storage at the shell level

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
* [Tabs →](./taps/)
  * [tap_home](./taps/tap_home/overview.md)
