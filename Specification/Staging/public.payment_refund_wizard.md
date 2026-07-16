# payment_refund_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the "Refund Management" business process. It acts as a transient or wizard-based staging entity used to capture user input during the initiation of a payment refund, specifically tracking the amount to be refunded against a specific payment record before the transaction is finalized in the ledger.

## Description
One row in this table represents a single refund request session or "wizard" instance initiated by a user. It serves as a raw landing copy of the wizard's state, capturing the intended refund amount and audit metadata for the lifecycle of the refund request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| payment_id | INTEGER | true | Foreign key to the payment being refunded | Links to the source payment record. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| amount_to_refund | NUMERIC | true | The monetary value requested for refund | Precision/scale not explicitly defined; check source DDL. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `payment.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo pattern).
    - `write_uid` → `res_users.id` (Standard Odoo pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may link to PII in the `res_users` table.
- **Lifecycle:** As a "wizard" table, rows may be transient or intended for deletion after the refund process is completed; ensure queries account for potentially short-lived data.
- **Precision:** The `amount_to_refund` column uses a generic `NUMERIC` type; verify the scale and precision in the source database to prevent rounding errors in financial reporting.