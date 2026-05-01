# 📌 Sections (Categories)

---

## 📖 Overview

Serves as the primary directory for the e-commerce platform, displaying a structured grid of all major product categories so users can drill down into specific domains.

---

## 🎯 Responsibilities

- Fetch and display all product categories (sections)
- Handle loading, error, and empty states via `FastStateRender`
- Navigate user to `ProductsView` with the selected `sectionId` on tap

---

## 🧠 System Behavior / Approach

The `SectionsView` uses `CustomScrollView` + `SliverGrid` to render categories dynamically. Given that root categories change infrequently, this data is an excellent candidate for Riverpod's `keepAlive` caching to prevent redundant network requests upon rapid tab switching.

`CustomCachedImage` provides loading skeletons and prevents visual popping when category images are fetched.

---

## 🔁 Data Flow

1. User navigates to `SectionsView`
2. `SectionsController` triggers `SectionsRepository.getAllSections()`
3. `FastStateRender` shows loading skeleton
4. On success → `SliverGrid` of `SectionCard` widgets rendered
5. User taps a `SectionCard` → navigate to `ProductsView` with `sectionId`

---

## 🧱 Architecture Summary

### 📱 Presentation

- `SectionsView` → `CustomScrollView` + `SliverGrid`; wrapped in `FastStateRender`
- `SectionCard` → Category card with image, localized title, optional indicator

- `SectionsController` → Notifier/provider fetching all sections and maintaining `ReqState`

---

### 🧠 Domain

- *(Planned)* `GetAllSectionsUseCase` → Validates and retrieves category list

---

### 💾 Data

- `SectionsRepository.getAllSections()` → Remote API call
- Caching: `keepAlive` Riverpod strategy recommended (categories change infrequently)

## 🔗 Related

* [Flow](./flow.md)
* [API](./api.md)
* [Screens](./screens.md)
