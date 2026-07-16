# product_label_layout

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the sequence-based default for the `id` column, is a standard pattern for Odoo's ORM-managed tables.

## Functional process 
This table supports the product labeling and inventory reporting process. It stores configuration settings for how product labels are generated and printed, specifically managing custom quantities, pricelist associations, and HTML-based layout templates used during warehouse operations or point-of-sale activities.

## Description
One row in this table represents a specific configuration profile or layout template for printing product labels. It serves as a raw landed copy of the Odoo configuration entity, capturing the formatting rules and quantity logic applied when generating labels for inventory items.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_label_layout_id_seq`. |
| custom_quantity | INTEGER | false | Default quantity for labels | Used when printing labels for a specific quantity. |
| pricelist_id | INTEGER | true | Foreign key to pricelist | Links to the pricing configuration used for label values. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this layout record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| print_format | VARCHAR | false | Label format identifier | Defines the template style (e.g., 'zpl', 'pdf'). |
| extra_html | TEXT | true | Custom HTML template | Stores additional layout styling or content. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| move_quantity | VARCHAR | false | Quantity source logic | Defines how quantity is calculated (e.g., 'move', 'custom'). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pricelist_id` → `product_pricelist.id` (Guess: standard Odoo naming convention for pricelist relations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field for user creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field for user modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by business logic.
- **Data Integrity:** `pricelist_id` is nullable, implying some label layouts may be generic and not tied to a specific pricing strategy.
- **Sensitive Data:** No PII is present, though `create_uid` and `write_uid` link to internal user identities.