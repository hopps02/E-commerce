# 🔄 Home Flow

---

## 👤 User Flow

1. User completes auth → navigates to `HomeView`
2. Default tab (index 0) = `TapHomeView` is displayed
3. User taps bottom nav items to switch tabs:

   * Tab 0 → `TapHomeView` *(Home)*
   * Tab 1 → Cart tab
   * Tab 2 → My Orders tab
   * Tab 3 → Profile tab

4. Each tab preserves its state when the user switches away and returns

---

## 🔁 System Flow

AuthSuccessView → HomeView → PageSlider (PageView) → [Tab 0 active by default]

BottomNav tap → BottomNavigationController.setIndex(n) → PageSlider animates to tab n

---

## ⏱️ Special Logic

* **`AutomaticKeepAliveClientMixin`**: All tab views use `keepAlive` — state is preserved across tab switches, preventing unnecessary rebuilds and re-fetches

---

## ⚠️ Edge Cases

* [ ] Tab switch while a request is in flight → request continues; tab state preserved
* [ ] App resumes from background → tab state preserved (no re-init)

---

## 📍 Navigation

* From → `AuthSuccessView` (post-login, stack cleared)
* Within → tab switching via `BottomNavigation`
* Each tab manages its own outbound navigation independently

---

## 🗂️ Tab Flows

| Tab | View | Doc |
|-----|------|-----|
| 0 | `TapHomeView` | [→ tap_home/flow.md](./taps/tap_home/flow.md) |
| 1 | Cart | *(to be added)* |
| 2 | My Orders | *(to be added)* |
| 3 | Profile | *(to be added)* |
