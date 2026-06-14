# 📌 Address Form

> Add/edit screen for a delivery address, gated by a GPS pick + coverage check.

---

## 🎯 Purpose

Lets the customer create or edit a `DeliveryAddress`. The customer picks a point with "use my location", which is geocoded and coverage-checked; the verified lat/lng/cityId is what actually gets saved, plus free-text fields (street, building, floor, etc.) and a label (home/work/other).

---

## 🧱 Key Classes

- `AddressFormView` (`AddressFormArgs`) — main screen (text controllers + location row + label chips)
- `AddressFormNotifier` / `addressFormController` — handles `initFrom`, `useMyLocation`, `selectLabel`, `save`
- `createAddressUseCase` / `updateAddressUseCase` / `coverageCheckUseCase` — create (POST), edit (PATCH), serviceability check
- `CreateAddressParams` / `UpdateAddressParams` / `CoverageResult`, `DeliveryAddress` — backend contract

---

## 🔁 Flow (brief)

UI → AddressFormNotifier → UseCase → RepositoryImpl → CustomerApi → state update

---

## ⚠️ Gotchas / Non-obvious behavior

- **Saving is location-gated**: `save()` bails (snackbar) unless `state.hasLocation` (lat + lng + cityId all set). Free-text alone is not enough.
- `useMyLocation()` runs permission → GPS → geocode via `locationController`, then `coverageCheckUseCase`. GPS has **no natural deadline**, so the fetch is hard-capped at a 12s timeout to avoid an endless loading overlay (e.g. a simulator with no simulated location).
- Coverage gate: if the point is `!isServiceable` or `cityId == null`, it shows `error_outside_delivery_zone` and does **not** set the location — the only way to get a serviceable cityId.
- The form's text fields are plain `TextEditingController`s (not in Riverpod state); only location + label live in the controller. `_save` does a minimal client check (display address non-empty) before delegating.
- Edit vs create branches on `existing`: create uses typed `CreateAddressParams`; update sends a raw `changes` map (empty strings instead of nulls). `initFrom` pre-seeds lat/lng/cityId so an unchanged edit still passes the location gate.
- Underlying GPS/geocoding helper is `LocationService` (`app/services/location_service.dart`) — handles permanently-denied permission and picks placemark[1] when available for a friendlier city name.

---

## 🔗 Related

- API endpoints: `POST /mobile/addresses`, `PATCH /mobile/addresses/{id}`, `POST /mobile/location/coverage-check` (full schema in Postman)
- Linked features: `addresses`, `location_service`, `checkout`

---

_Last updated: 2026-06-14 · Owner: Antigravity_
