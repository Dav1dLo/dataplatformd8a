# payment_capture_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the payment processing and order fulfillment pipeline. It acts as a temporary state holder or "wizard" interface for capturing authorized payments against sales orders or invoices, allowing users to specify partial capture amounts or trigger the voiding of remaining authorized funds.

## Description
One row in this table represents a single execution instance of a payment capture operation within the application UI. It serves as a staging entity that tracks the parameters of a pending or completed payment capture request before the transaction is finalized in the core ledger.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `payment_capture_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who initiated the capture | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| amount_to_capture | NUMERIC | true | Monetary value to be captured | Precision/scale not specified; confirm against source DDL. |
| void_remaining_amount | BOOLEAN | true | Flag to void unused authorization | If true, releases the remaining hold on the payment method. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for creator).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user directories for PII masking if required.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Lifecycle:** This table represents a "wizard" state; rows may be transient or ephemeral depending on the application's cleanup policy for completed wizard sessions.
- **Precision:** The `NUMERIC` type for `amount_to_capture` lacks defined scale; ensure downstream casting handles currency rounding appropriately.