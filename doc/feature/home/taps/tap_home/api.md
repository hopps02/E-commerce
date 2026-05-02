# 🌐 Home Tab API

---

> ⚠️ API not yet integrated. All endpoints below are planned.

---

## 🔹 Get Banners *(Planned)*

**URL:** `/banners`
**Method:** `GET`

---

### 📥 Response

> ⚠️ Not yet implemented — expected to return a list of promotional banner entities (image URL, link target, display order)

---

### ❌ Errors

* 401 → Unauthorized
* 500 → Server error

---

## 🔹 Get Sections / Categories *(Planned)*

**URL:** `/sections`
**Method:** `GET`

> See full spec in [Sections API](../../../sections/api.md)

---

## 🔹 Get Featured Products *(Planned)*

**URL:** `/products/featured`
**Method:** `GET`

---

### 📥 Response

> ⚠️ Not yet implemented — expected to return a curated list of `ProductEntity`

---

### ❌ Errors

* 401 → Unauthorized
* 500 → Server error

---

## 🔹 Notes

* Requires authentication: Yes
* Headers: `Authorization: Bearer <token>`
* All 3 fetches run in **parallel** via independent Riverpod providers
* A failure in one provider does not block or cancel the others
