# pos_category

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized fields like `name`, and the reliance on standard PostgreSQL sequences for primary keys.

## Functional process 
This table supports the Point of Sale (POS) product categorization process. It manages the hierarchical structure of product categories used to organize items within the POS interface, allowing for nested categories via the `parent_id` relationship.

## Description
One row represents a single product category definition within the Point of Sale module. This is a raw landed staging table containing the structural metadata for category trees, including display order and UI styling attributes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_category_id_seq`. |
| parent_id | INTEGER | true | Self-referencing foreign key | Defines the parent category for hierarchical nesting. |
| sequence | INTEGER | true | Display order index | Used to sort categories in the POS UI. |
| color | INTEGER | true | UI color index | Represents the color code assigned to the category. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Category name | Likely contains multilingual strings; requires parsing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `public.pos_category.id`: Establishes the parent-child relationship for category trees.
    - `create_uid` → `public.res_users.id` (guess): Standard Odoo pattern for audit tracking.
    - `write_uid` → `public.res_users.id` (guess): Standard Odoo pattern for audit tracking.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Parsing:** The `name` column is stored as `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract readable text.
- **Timestamps:** Timestamps are stored as `TIMESTAMP` (without timezone). Assume these are in the application's configured timezone (typically UTC, but verify against Odoo system settings).
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; check if the source system uses a separate mechanism for logical deletion.
- **Audit Columns:** `create_date` and `write_date` are application-level timestamps and may not reflect the exact time the record was ingested into the staging layer.