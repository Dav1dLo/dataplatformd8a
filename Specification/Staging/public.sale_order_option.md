# sale_order_option

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`sale_order_option`), the use of `create_uid`/`write_uid` for audit tracking, and the specific sequence-based primary key generation pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the "Quote-to-Cash" process, specifically managing optional products or "upsell" items associated with a sales quotation. It allows sales representatives to present additional products to a customer during the quotation phase that are not part of the main order lines but can be added if the customer chooses.

## Description
One row represents a single optional product line item linked to a specific sales order. It acts as a raw landed copy of the Odoo `sale_order_option` model, capturing the product, quantity, pricing, and discount details for potential upsell items.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `sale_order_option_id_seq`. |
| order_id | INTEGER | true | Foreign key to the parent sales order | Links to the `sale_order` table. |
| product_id | INTEGER | false | Foreign key to the product | Links to the `product_product` table. |
| line_id | INTEGER | true | Reference to a specific order line | Optional link to an existing order line. |
| sequence | INTEGER | true | Display order index | Used for UI sorting of options. |
| uom_id | INTEGER | false | Unit of measure ID | Links to `uom_uom` table. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users` table. |
| name | TEXT | false | Description of the option | The display name for the optional item. |
| quantity | NUMERIC | false | Quantity offered | The amount of the product proposed. |
| price_unit | NUMERIC | false | Unit price | The price per unit of the option. |
| discount | NUMERIC | true | Discount percentage | Expressed as a percentage (e.g., 10.00). |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id` (Evidence: naming convention and functional role in sales).
    - `product_id` → `product_product.id` (Evidence: standard Odoo schema pattern).
    - `uom_id` → `uom_uom.id` (Evidence: standard Odoo schema pattern).
    - `create_uid` / `write_uid` → `res_users.id` (Evidence: standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are assumed to be active unless removed from the source.
- **Precision:** `NUMERIC` types do not specify scale/precision in the schema; verify against source DDL if high-precision financial rounding is required.
- **Sensitivity:** Contains no direct PII, though `create_uid` and `write_uid` link to user metadata.