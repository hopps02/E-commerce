# 📌 Addresses

> Lists the customer's saved delivery addresses with set-default, edit and delete.

---

## 🎯 Purpose

Shows the customer's saved `DeliveryAddress` list and lets them manage it: open the form to add/edit, mark one as default, or delete. Delivery selection elsewhere in the app depends on these addresses existing.

---

## 🧱 Key Classes

- `AddressesView` — main screen (list of `AddressCard`s + "add address" button)
- `AddressesNotifier` / `addressesController` — handles `load`, `setDefault`, `delete`
- `getAddressesUseCase` / `updateAddressUseCase` / `deleteAddressUseCase` — list, set-default (PATCH), delete
- `DeliveryAddress` (`catalog_response.dart`) — backend contract

---

## 🔁 Flow (brief)

UI → AddressesNotifier → UseCase → RepositoryImpl → CustomerApi → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- The **default invariant lives on the backend**: first address is default, setting one un-defaults the rest, deleting reassigns server-side. The app just `load()`s again after each mutation — it never reorders locally.
- `setDefault` is implemented as an `updateAddress` PATCH with `{'is_default': true}`, not a dedicated endpoint.
- Returning from the form (`_openForm`) always triggers a fresh `load()` so edits/adds show up — even on the back-button path.
- `delete` first awaits a `DeleteAddressBottomSheet` confirmation; it no-ops unless the sheet returns `true`.
- `setDefault`/`delete` drive the global `loadingService` overlay; `load()` drives the in-list `reqState` (loading/empty/error/success) instead.
- Controller is `autoDispose` — state resets when the screen leaves the tree, hence the `initState` `load()`.

---

## 🔗 Related

- API endpoints: `GET /mobile/addresses`, `PATCH /mobile/addresses/{id}`, `DELETE /mobile/addresses/{id}` (full schema in Postman)
- Linked features: `address_form`, `cart`, `checkout`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
