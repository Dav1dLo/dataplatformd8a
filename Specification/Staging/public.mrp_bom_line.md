# mrp_bom_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_bom_line`, `product_tmpl_id`, `product_uom_id`) and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the manufacturing bill of materials (BOM) management process. It defines the specific components, quantities, and operational requirements needed to produce a finished good or sub-assembly, linking raw materials or intermediate products to a parent BOM.

## Description
One row in this table represents a single line item within a Bill of Materials, specifying a component required for a manufacturing process. This is a raw landed copy of the Odoo `mrp.bom.line` model, capturing the relationship between a parent BOM and its constituent products at the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_bom_line_id_seq`. |
| product_id | INTEGER | false | Foreign key to product variant | The specific item required. |
| product_tmpl_id | INTEGER | true | Foreign key to product template | The base product definition. |
| company_id | INTEGER | true | Foreign key to company | Multi-company isolation identifier. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | The unit in which the quantity is measured. |
| sequence | INTEGER | true | Display order | Used to sort lines in the UI. |
| bom_id | INTEGER | false | Foreign key to parent BOM | The BOM header this line belongs to. |
| operation_id | INTEGER | true | Foreign key to manufacturing operation | The specific work step where this component is consumed. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| product_qty | NUMERIC | false | Required quantity | The amount of the product needed. |
| manual_consumption | BOOLEAN | true | Manual consumption flag | Indicates if consumption is tracked manually. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |
| cost_share | NUMERIC | true | Cost allocation percentage | Used for byproduct cost distribution. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo link to product variant)
    - `bom_id` → `mrp_bom.id` (Links line to parent BOM header)
    - `product_uom_id` → `uom_uom.id` (Links to unit of measure definition)
    - `company_id` → `res_company.id` (Links to organizational entity)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal relational integrity.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard Odoo behavior where records are physically deleted or managed via application-level logic.
- **Precision:** `product_qty` and `cost_share` are `NUMERIC` types; ensure downstream transformations handle potential floating-point precision requirements appropriately.
- **Sensitivity:** Contains no direct PII, though `create_uid` and `write_uid` link to internal user records which may be considered sensitive in some contexts.