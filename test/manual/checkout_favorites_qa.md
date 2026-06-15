# Manual QA — Checkout quote integrity + Favorites (Batch A/B)

These flows exercise controller paths that cannot be unit-tested today because
the DI container exposes its repository through **private** providers (so the
network use cases can't be mocked without a DI testability hook). Run on a real
device/simulator against the live API. Pure logic (fingerprint, `matchesCart`,
favorites optimistic/rollback, `seedFrom`) IS covered by unit tests; this script
covers the network-coupled behavior.

## A. Checkout quote invalidation (Batch A + P1 #4)

Pre: a customer with a saved central-Riyadh address and items in the cart.

1. **Stale-quote on edit** — Open cart (quote loads). Change a quantity.
   - ✅ Shipping + grand total show a spinner ("updating") immediately, then
     refresh from the server; product/discount rows update live.
   - ✅ The displayed grand total equals the server `total_halalas` (not a
     client re-derivation).
2. **Remove item** — Remove a line.
   - ✅ Same updating→refresh. Remove the last line → cart goes empty, bar hides.
3. **Address reprice** — On Confirm, change to an address in a different zone.
   - ✅ Delivery fee + total reprice to the new zone.
4. **Edit then jump to Confirm fast** — On cart, change qty then immediately tap
   "Order now" (within ~½s).
   - ✅ Confirm screen shows a FRESH quote (no stale total); CTA is disabled
     until the quote settles.
5. **Force-quote on confirm tap (P1 #4)** — On Confirm, with totals shown, tap
   "Confirm order".
   - ✅ Spinner shows inside the button only (no full-screen blocker).
   - ✅ If totals are unchanged → order is created in the same tap.
6. **Server price changed before confirm (P1 #4)** — Change a branch item's
   price/delivery fee server-side (admin panel / DB) while sitting on Confirm,
   then tap Confirm.
   - ✅ The order is NOT created on that tap. The UI updates to the new total and
     a localized snackbar shows:
     - ar: "تم تحديث إجمالي الطلب. راجع السعر ثم أكد مرة أخرى."
     - en: "Order total was updated. Please review it and confirm again."
   - ✅ Tapping Confirm again (totals now stable) creates the order.
7. **Stock dropped before confirm (P1 #4)** — Reduce a cart item's stock below
   the cart quantity server-side, then tap Confirm.
   - ✅ Order blocked; the stock/availability error is shown; user stays on
     checkout (createOrder is authoritative and rejects).
8. **Quote/network failure on confirm (P1 #4)** — Kill network, tap Confirm.
   - ✅ Order NOT created; a retryable error is shown; user stays on checkout.
9. **Charge integrity** — After a successful order, confirm the created order's
   `total_halalas` equals the total the UI last showed before confirming.

## B. Favorites (Batch B)

10. **Heart sync** — Heart an item → it fills and appears in Favorites; un-heart →
    removed from both the heart and the list.
11. **Failed toggle rollback (B #1)** — Offline, tap a heart.
    - ✅ The heart reverts AND no phantom row lingers in Favorites (full rollback).
12. **Rapid same-product taps (P1 #5)** — Tap the same heart rapidly several times.
    - ✅ No flicker/desync; the final heart state matches the backend (only one
      in-flight request per product; extra taps ignored until it resolves).
13. **Cross-list reconcile (P2 #6)** — Favorite an item, un-favorite it from
    another surface/device, then re-open a product list containing it.
    - ✅ The heart clears to match `is_favorite=false` (no stale filled heart);
      hearts for items NOT in that list are unaffected.
14. **Inactive item hygiene (P0 #3, backend)** — Hide a favorited item (or suspend
    its branch) in the admin panel.
    - ✅ It disappears from the Favorites list; favoriting a hidden item via the
      app is rejected; an existing (now-hidden) favorite can still be removed.
