# 🌐 Product Details API

---

## 🔹 Get Product By ID *(Planned)*

**URL:** `/products/{id}`
**Method:** `GET`

---

### 📥 Response

> ⚠️ API not yet integrated — expected to return full `ProductEntity` including images, variants, pricing, description

---

### ❌ Errors

* 401 → Unauthorized
* 404 → Product not found
* 500 → Server error

---

## 🔹 Notes

* Requires authentication: Yes
* Headers: `Authorization: Bearer <token>`
* Controller is `AutoDispose` — no caching needed at Riverpod level for this screen
