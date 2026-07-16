# product_combo_item

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the product configuration and bundling process, specifically defining the components that make up a product combo or kit. It tracks which individual products are associated with a specific combo and any additional pricing applied to those items within the bundle.

## Description
One row in this table represents a single component item assigned to a specific product combo. It serves as a raw landing copy of the relationship between parent combo products and their constituent child products, facilitating the calculation of bundle pricing and inventory requirements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_combo_item_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Multi-tenant identifier. |
| combo_id | INTEGER | false | Foreign key to the parent combo product | Links to the main product record. |
| product_id | INTEGER | false | Foreign key to the component product | The specific item included in the combo. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| extra_price | NUMERIC | true | Price adjustment for this component | Unit price delta; precision depends on system config. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (standard Odoo multi-company pattern).
    - `combo_id` → `product_product.id` (links to the parent combo product).
    - `product_id` → `product_product.id` (links to the component product).
    - `create_uid` / `write_uid` → `res_users.id` (standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against system settings if time-zone sensitive calculations are required.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume records are hard-deleted if they disappear from the source.
- **Precision:** The `extra_price` column is `NUMERIC` without defined scale/precision; check source DDL for rounding rules (typically 2 or 4 decimal places in Odoo).
- **Audit Columns:** `create_uid` and `write_uid` are internal system IDs and may not be human-readable without joining to the `res_users` table.