# product_template_attribute_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`product_template_attribute_line`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the product catalog management process, specifically defining which attributes (e.g., Color, Size) are assigned to a specific product template. It acts as the bridge between a product definition and its configurable characteristics, enabling the generation of product variants.

## Description
One row represents the association of a single attribute to a product template, defining the configuration structure for that product. This is a raw landed staging table containing the direct mapping of attributes to templates, used as the foundation for building product variant dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_template_attribute_line_id_seq`. |
| product_tmpl_id | INTEGER | false | Foreign key to product template | Links to the parent product definition. |
| sequence | INTEGER | true | Display order index | Determines the order in which attributes appear in the UI. |
| attribute_id | INTEGER | false | Foreign key to attribute definition | Identifies the specific attribute (e.g., Color). |
| value_count | INTEGER | true | Count of attribute values | Denormalized count of values associated with this line. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the system user table. |
| active | BOOLEAN | true | Soft-delete flag | If false, the attribute line is hidden from the product. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_tmpl_id` → `product_template.id`: Links the attribute line to the specific product template.
    - `attribute_id` → `product_attribute.id`: Links the line to the master attribute definition.
    - `create_uid` / `write_uid` → `res_users.id`: Links to the user who performed the action (guess based on Odoo schema).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs and may not be resolvable without joining to the `res_users` table.
- **Data Integrity:** As a staging table, this may contain transient records or duplicates if the ingestion process does not deduplicate source system updates.