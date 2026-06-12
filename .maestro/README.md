# For You — Maestro E2E Suite

End-to-end flows for the three apps (customer / cashier / captain) against a
local backend. Every flow drives the real UI on a simulator and asserts real
API state.

## Prerequisites

```bash
# 1. Backend (4u-backend repo, branch feat/mobile-reorder-enrich or later)
php artisan serve --port=8000              # .env has OTP_FAKE_IN_LOCAL=true (code 000000)
php artisan db:seed --class=DemoPanelSeeder # idempotent: demo city/branch/products/zone/addresses
php artisan queue:work --sleep=2 &          # notifications are queued (QUEUE_CONNECTION=database)

# 2. App build on the QA simulator (keep it the ONLY booted device)
export PATH="$HOME/.rbenv/shims:$PATH"
~/fvm/versions/3.38.9/bin/flutter build ios --simulator --debug
xcrun simctl install <SIM_UDID> build/ios/iphonesimulator/Runner.app
# default BASE_URL is http://127.0.0.1:8000/api/v1 (see lib/app/config/env.dart)

# 3. Run a flow
~/.maestro/bin/maestro test .maestro/<flow>.yaml
```

**Demo accounts** (OTP code is always `000000`): customers `500003001..3011`,
cashier `560002000` (فهد), captain `550001000` (ناصر), kept staff demo data in
`DemoPanelSeeder`.

## Suites

### Acceptance (app-by-app visual review)
- `qa_cashier_acceptance` / `qa_cashier_finish_assign` / `qa_cashier_final_shot`
- `qa_captain_acceptance` / `qa_captain_completed_shot`
- `qa_customer_acceptance` / `qa_customer_rated_state`

### Purchase loop (customer shops for real)
- `qa_customer_purchase_e2e` — login → real home → search → details → cart
  (2 items) → checkout → place order → success → order details → my orders.

### Full lifecycle (the production story)
- `qa_lifecycle_a_cashier` → `qa_lifecycle_a_captain` →
  `qa_lifecycle_a_customer_rate` — place → prepare → assign → deliver → rate.
  Update the hardcoded order number (GOC-…) to the order under test first.
- `qa_lifecycle_b_*` — same loop AFTER a missing-item removal (the removal
  itself is `POST /cashier/orders/{id}/items/{item}/unavailable`; no mobile
  affordance yet). Asserts the removed line is gone everywhere and the
  recalculated COD total shows.
- `qa_lifecycle_b2_rejected` — all lines removed → auto-reject; the customer
  sees the rejected order with no rate button.
- `qa_lifecycle_c1_out_of_stock` / `c2a` / `c2b` / `c2c` — sold-out details
  state, stale-cart order rejection, and the cart clamp + toast. c-flows need
  a tinker step between them to change `branch_items.stock_on_hand` (restore
  it after).

### Utilities / recovery
- `qa_customer_logout`, `qa_recover_logout`, `qa_recover_logout2` — log out a
  stuck session (customer via profile; staff via the home header).
- `qa_lifecycle_b_deliver_point`, `qa_tap_confirm_point` — point-tap variants
  for buttons that miss text-located taps.
- `*_continue` flows — mid-run resumes kept for reference.
- `auth_login_cashier`, `cashier_*`, `captain_*`, `customer_orders_rate_e2e` —
  the original wiring-era smoke flows.

## Hard-won gotchas

- **CustomInkButton misses text-located taps intermittently** — use
  `point:` taps for critical buttons (confirm order ≈ `50%,91%`, deliver ≈
  `50%,82%`, details back chevron ≈ `89%,11%`).
- **Merged text nodes need regex** — `".*عرض السلة.*"`, never the bare string.
- **OTP**: type the 6 digits as six separate `inputText: "0"` steps (bulk
  input drops the last char). The hourly throttle is a cache RateLimiter
  (key `otp:req:+966…`) — clear with `RateLimiter::clear(...)` in tinker; the
  60s resend cooldown lives on `otp_codes.last_sent_at` (backdate it). Never
  poll request-otp in a loop: every call restarts the cooldown.
- **The Maestro iOS driver wedges after many runs** — steps report COMPLETED
  but nothing happens on screen (even stopApp). `pkill -f maestro` and rerun.
- **Keep the QA simulator the only booted device** — other simulators steal
  the foreground mid-flow.
- **Cashier preparation queue is FIFO** (oldest first); customer/captain
  lists are newest first. Scroll accordingly.
- Verify which binary the sim runs after a rebuild:
  `strings <app>/Frameworks/App.framework/flutter_assets/kernel_blob.bin | grep <new-string>`.
