# stock_track_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory tracking and wizard-based stock management process. It acts as a transient or auxiliary storage for tracking lines associated with specific stock-related operations or configuration wizards, linking products to specific workflow sessions.

## Description
One row in this table represents a single tracking line entry associated with a stock management wizard or process. It serves as a raw landed copy of the tracking data, capturing the association between a product and a specific wizard session, along with audit metadata for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| product_id | INTEGER | true | Foreign key to the product | References the product being tracked. |
| wizard_id | INTEGER | true | Foreign key to the wizard | References the parent wizard session. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product reference).
    - `wizard_id` → `stock_track_wizard.id` (Guess: inferred from the column name pattern).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to identify individuals.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Data Retention:** This is a staging table; verify if the upstream process performs hard deletes or if historical records are maintained.
- **Nullability:** Most fields are nullable, suggesting that tracking lines may exist in various states of completion within the wizard workflow.