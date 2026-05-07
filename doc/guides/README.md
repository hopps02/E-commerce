# 📘 Mawadk Documentation

Welcome. This folder is the source of truth for how this project is built and how to contribute.

---

## 🗺️ Where to start

1. **[ARCHITECTURE.md](./ARCHITECTURE.md)** — the layers (Presentation / Domain / Data), how they talk to each other, and the core patterns (DI, error handling, data flow).
2. **[CONTRIBUTING.md](./CONTRIBUTING.md)** — commit conventions, branch naming, code standards.
3. **[testing/testing_strategy.md](./testing/testing_strategy.md)** — unit, logic-integration, and folder conventions.

---

## 📝 Documenting a feature — pick a strategy

Two strategies are available. Pick whichever matches the feature's complexity.

| Strategy | Folder | When to use |
|---|---|---|
| 🪶 **Simple** (default) | [`doc_simple/`](./doc_simple/README.md) | Most features. One short `README.md` per feature. |
| 🏛️ **Full** | [`doc_strategy/`](./doc_strategy/README.md) | Complex features only (auth, payment, multi-step flows). Four files per feature. |

When in doubt → start simple. Upgrade later if the feature grows.

---

## 📂 Layout

```
doc/
├── ARCHITECTURE.md          # high-level architecture
├── CONTRIBUTING.md          # workflow + code standards
├── README.md                # you are here
│
├── doc_strategy/            # 🏛️ full template (4 files per feature)
│   ├── README.md
│   ├── overview.md
│   ├── flow.md
│   ├── api.md
│   └── screens.md
│
├── doc_simple/              # 🪶 simple template (1 file per feature)
│   ├── README.md
│   └── template.md
│
├── features/                # one folder per documented feature
│   ├── README.md            # index of features
│   └── sign_in/             # example: full template
│
└── testing/
    └── testing_strategy.md
```

---

## ➕ Adding docs for a new feature

1. Pick a strategy (simple by default — see the table above).
2. Create `doc/features/<feature_name>/`.
3. Copy the matching template:
   - **Simple** → copy `doc_simple/template.md` to `doc/features/<feature_name>/README.md`.
   - **Full** → copy all four files from `doc_strategy/` into `doc/features/<feature_name>/`.
4. Add a one-line entry to [`features/README.md`](./features/README.md).

---

## 🧭 External sources of truth

- **API**: Postman / Swagger — not duplicated here.
- **Designs**: Figma — not duplicated here.
- **Backlog**: GitLab Issues.
