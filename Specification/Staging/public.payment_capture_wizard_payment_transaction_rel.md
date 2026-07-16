# payment_capture_wizard_payment_transaction_rel

## Source system
The table likely originates from a custom-built internal application or a modular ERP system, given the naming convention `payment_capture_wizard`. This suggests a multi-step UI-driven payment process where transactions are associated with specific wizard sessions.

## Functional process 
This table supports the payment processing pipeline by maintaining the association between a specific payment capture session (the "wizard") and the resulting financial transaction. It acts as a bridge table to resolve a many-to-many or one-to-many relationship between the user's interaction flow and the backend transaction records.

## Description
One row in this table represents a single link between a payment capture wizard session and a payment transaction. It serves as a raw landed join table in the staging layer, used to reconstruct the relationship between user-initiated payment flows and the final transaction state.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_capture_wizard_id | INTEGER | false | Foreign key to the payment capture wizard session | Links to the session identifier. |
| payment_transaction_id | INTEGER | false | Foreign key to the payment transaction record | Links to the specific transaction identifier. |

## Keys

- **Primary key (inferred):** The combination of `(payment_capture_wizard_id, payment_transaction_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `payment_capture_wizard_id` → `payment_capture_wizard.id` (guess: standard naming convention for parent entity).
    - `payment_transaction_id` → `payment_transaction.id` (guess: standard naming convention for parent entity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; ensure joins are handled carefully to avoid fan-out if a wizard session is associated with multiple transactions.
- No audit timestamps (e.g., `created_at`) are present, so the sequence of associations cannot be determined from this table alone.
- The table contains no PII, but represents sensitive financial linkage data.