# 🌐 Search API

---

## 🔹 Search Products *(Planned)*

**URL:** `/products/search`
**Method:** `GET`

---

### 📤 Request

> ⚠️ API not yet integrated

```json
{
  "query": "apple"
}
```

---

### 📥 Response

> ⚠️ Not yet implemented — expected to return paginated list of `ProductEntity`

---

### ❌ Errors

* 400 → Bad request (empty query)
* 401 → Unauthorized
* 500 → Server error

---

## 🔹 Search History

* Stored locally via `SearchHistoryRepository`
* Uses SharedPreferences or Hive
* No API endpoint — purely local persistence

---

## 🔹 Notes

* Requires authentication: Yes
* Headers: `Authorization: Bearer <token>`
* Debounce is applied client-side (500ms) before triggering the request
