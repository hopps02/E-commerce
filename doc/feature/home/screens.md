# 🖥️ Home Screens

---

## 📱 HomeView

**Purpose:**
Root authenticated scaffold. Pure navigation shell — hosts the bottom nav bar and manages tab switching via `PageSlider`.

---

### 🧩 Components

* `PageSlider` → `PageView` hosting all 4 tab views (state preserved via `keepAlive`)
* `GradientBackground` → Decorative gradient overlay
* `BottomNavigation` → Custom floating bottom nav bar
* `BottomNavigationBar` (widget) → Visual rendering of 4 nav items (Home, Cart, Orders, Profile)

---

### 🔗 State Management

* Connected to `BottomNavigationController`
* Observes: selected tab index

---

### ⚡ Actions

* Bottom nav item tap → `BottomNavigationController.setIndex(n)` → `PageSlider` switches to tab `n`

---

### ⚠️ States

* Static shell — no loading / error / empty states at this level
* Each tab manages its own states independently

---

## 🗂️ Tab Screens

| Tab | Screen | Doc |
|-----|--------|-----|
| 0 — Home | `TapHomeView` | [→ tap_home/screens.md](./taps/tap_home/screens.md) |
| 1 — Cart | *(to be added)* | *(to be added)* |
| 2 — My Orders | *(to be added)* | *(to be added)* |
| 3 — Profile | *(to be added)* | *(to be added)* |
