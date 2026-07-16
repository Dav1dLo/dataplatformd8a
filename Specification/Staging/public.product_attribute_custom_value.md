# product_attribute_custom_value

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`product_attribute_custom_value_id_seq`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific linkage to point-of-sale and sales order line identifiers.

## Functional process 
This table supports the custom product configuration process within the sales and point-of-sale modules. It stores user-defined attribute values for products that have been customized during the ordering process, linking these specific text inputs to either a `pos_order_line_id` or a `sale_order_line_id`.

## Description
Each row represents a single custom attribute value assigned to a specific product line item within an order. It acts as a raw staging record that captures the text-based customization provided by a user during the checkout or quoting process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-increment. |
| custom_product_template_attribute_value_id | INTEGER | false | Reference to the attribute definition | Links to the product template attribute value configuration. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| custom_value | VARCHAR | true | The actual text input provided | The user-entered customization string. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| pos_order_line_id | INTEGER | true | Link to POS order line | References `pos_order_line`. |
| sale_order_line_id | INTEGER | true | Link to Sales order line | References `sale_order_line`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `pos_order_line_id` → `pos_order_line.id` (Evidence: column name suffix)
    - `sale_order_line_id` → `sale_order_line.id` (Evidence: column name suffix)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `custom_value` column may contain PII if users enter names, addresses, or other personal details into custom product fields.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume records are hard-deleted if removed from the source.
- **Nullability:** Either `pos_order_line_id` or `sale_order_line_id` is likely populated depending on the sales channel, but the schema does not strictly enforce this via a check constraint.