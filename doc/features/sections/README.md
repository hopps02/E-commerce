# 📌 Sections (Categories)

> Primary directory displaying a structured grid of all major product categories for deep-dive browsing.

---

## 🎯 Purpose

The `SectionsView` serves as the app's catalog index. It organizes the product universe into distinct categories, providing users with a clear entry point to find what they need.

- Fetch and display a complete list of product categories (sections)
- Handle loading, error, and empty states via `FastStateRender`
- Navigate the user to the `ProductsView` filtered by the selected `sectionId` on tap

---

## 🧱 Key Classes

- `SectionsView` — grid-based screen using `CustomScrollView` and `SliverGrid`
- `SectionsController` — Notifier fetching the sections list and maintaining the `ReqState`
- `SectionCard` — modular card component displaying a category's image and localized title
- `SectionsRepository` — data source for retrieving category metadata

---

## 🔁 Flow (brief)

User opens SectionsView → `SectionsController` calls `SectionsRepository.getAllSections()`.

FastStateRender displays loading → Success → Grid rendered.

User taps category → Navigator.pushNamed('/products', arguments: sectionId).

---

## ⚠️ Gotchas / Non-obvious behavior

- **Caching Efficiency**: Root categories change infrequently. This feature is a primary candidate for Riverpod's `keepAlive` strategy, allowing the data to persist in memory and avoid redundant API calls when the user switches tabs.
- **Image Handling**: Utilizes `CustomCachedImage` to provide consistent loading skeletons, ensuring the grid remains visually stable while images are being fetched from the CDN.
- **Scalable Grid**: Uses a `SliverGrid` within a `CustomScrollView` to support future expansions (like adding promotional headers or mixed content types) without significant refactoring.

---

## 🔗 Related

- API endpoints: `GET /sections` (Planned)
- Linked features: `ProductsListing`, `HomeTab` (via "View All" link).

---

_Last updated: 2026-05-07 · Owner: Antigravity_
