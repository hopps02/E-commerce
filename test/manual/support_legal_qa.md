# Manual QA — Support tickets + Legal (Batch C)

Controller→network paths can't be unit-tested without a DI refactor (DI exposes its
repository through private providers), so this script covers the wired behaviour.
Pure parsing/state is unit-tested (`test/unit/data/models/support_models_test.dart`,
`test/unit/presentation/create_ticket_controller_test.dart`). Run on a device against
the live API (OTP `000000`).

## Customer support (full thread)
1. **Open + appears in list** — Profile → "Help & Support" opens **My Tickets** (not a FAQ).
   Tap **New Ticket** → fill subject + message → Send.
   - ✅ success snackbar; the ticket appears at the **top of the list** without a manual reload.
2. **List states** — Loading spinner first; if you have no tickets, the **empty state**
   ("No tickets yet") shows with the New Ticket FAB; pull-to-refresh works; scrolling pages more.
3. **Detail + thread** — Tap a ticket → the thread shows: your first message (= the description)
   right-aligned, support replies left-aligned, each with a time.
4. **Reply appends** — Type a reply → send.
   - ✅ the in-button spinner shows; the new message **appends** to the thread (no disappear);
     status updates if the backend changed it.
5. **Closed ticket → no reply** — Open a ticket the panel marked `closed`.
   - ✅ the reply bar is replaced by "This ticket is closed…"; you cannot reply.
6. **Optional linked order** — New Ticket → tap "Related order (optional)" → pick a recent order
   (or "No order — general inquiry") → Send.
   - ✅ a linked ticket routes to that order's merchant; a general ticket has no order.
   - ✅ the linked order shows on the **admin panel** ticket detail (see admin section).
7. **Error states are real** — Kill network mid-load → error + retry; mid-send → error snackbar,
   stays on screen, nothing silently dropped.

## Cashier / Captain (open ticket ONLY)
8. **Cashier** — Cashier home → header "Support" → subject + message → Send → `POST /cashier/tickets`.
   - ✅ real spinner, success snackbar, form clears, page pops. **No** ticket list/detail for staff.
9. **Captain** — Captain home → header "Support" → Send → `POST /captain/tickets`. Same as above.
10. **No full_name field** — the staff form is subject + message only (opener comes from auth).

## Legal
11. **Backend-driven** — Profile → "Legal & Policies" loads `GET /mobile/legal-policies`;
    sections render with locale titles (Terms / Privacy / Delivery / Refund).
12. **Honest empty body** — since v1 bodies are empty, each section shows the muted italic:
    - ar: "لم تتم إضافة المحتوى القانوني بعد."
    - en: "Legal content has not been added yet."
    - ✅ **no Lorem ipsum / placeholder copy anywhere**.

## Arabic RTL smoke
13. Switch to Arabic → My Tickets / detail / create / staff support / legal all read RTL,
    chips/bubbles mirror correctly, all copy is localized (no raw English).

## Admin panel (super-admin)
14. Open an admin ticket that has a linked order (partner-care) → the meta now shows
    **Related order / الطلب المرتبط = #<order_id>**. (Isolated panel change, see handoff.)
