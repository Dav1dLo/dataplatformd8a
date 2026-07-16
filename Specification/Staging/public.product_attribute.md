# product_attribute

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for multi-language fields (`name`), and the specific sequence-based default value pattern for the primary key.

## Functional process 
This table supports the Product Catalog management process, specifically defining the attributes (such as color, size, or material) that can be assigned to product variants. It manages the configuration of how these attributes are displayed in the user interface and tracks the audit trail for attribute creation and modification.

## Description
One row in this table represents a single product attribute definition within the system. It serves as a raw landed copy of the attribute configuration, capturing the metadata required to render and manage product variants at the grain of an individual attribute record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_attribute_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting attributes in UI. |
| create_uid | INTEGER | true | ID of user who created the record | References `res_users` table. |
| write_uid | INTEGER | true | ID of user who last modified the record | References `res_users` table. |
| create_variant | VARCHAR | false | Variant creation strategy | Defines how variants are generated from this attribute. |
| display_type | VARCHAR | false | UI rendering style | e.g., 'radio', 'select', 'color'. |
| name | JSONB | false | Attribute display name | Multi-language support; contains key-value pairs for locales. |
| active | BOOLEAN | true | Soft-delete flag | If false, the attribute is hidden from the catalog. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve PII.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical/deleted data is explicitly required.
- **JSONB:** The `name` column is a `JSONB` object; downstream consumers will need to use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract specific language values.