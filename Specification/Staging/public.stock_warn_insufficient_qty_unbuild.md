# stock_warn_insufficient_qty_unbuild

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_warn_insufficient_qty_unbuild`), the use of `create_uid`/`write_uid` audit columns, and the standard sequence-based primary key pattern common in Odoo's PostgreSQL backend.

## Functional process 
This table supports the inventory management and manufacturing process, specifically tracking warnings generated when an "unbuild" operation (disassembling a finished product back into components) cannot be completed due to insufficient stock quantities. It acts as a transient or logging mechanism to alert users during the unbuild workflow.

## Description
One row in this table represents a single instance of an insufficient stock warning triggered during an unbuild operation for a specific product at a specific location. It serves as a raw landed copy of the Odoo transient model, capturing the state of the warning at the time of the unbuild attempt.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_warn_insufficient_qty_unbuild_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product being unbuilt. |
| location_id | INTEGER | false | Foreign key to location | References the warehouse location where stock is checked. |
| unbuild_id | INTEGER | true | Foreign key to unbuild order | The specific unbuild operation that triggered the warning. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the unbuild attempt. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this warning record. |
| product_uom_name | VARCHAR | false | Unit of measure label | The display name of the unit of measure (e.g., 'Units', 'kg'). |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| quantity | DOUBLE PRECISION | false | Insufficient quantity | The amount of stock missing to complete the unbuild. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product reference).
    - `location_id` → `stock_location.id` (Guess: standard Odoo inventory location reference).
    - `unbuild_id` → `mrp_unbuild.id` (Guess: standard Odoo manufacturing unbuild reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against an employee or user table; no direct PII like names or emails are present.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely transient or appended.
- **Precision:** The `product_uom_name` is a string label; ensure downstream joins use the `product_id` rather than this label for accuracy.