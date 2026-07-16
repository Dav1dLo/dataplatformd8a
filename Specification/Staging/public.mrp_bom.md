# mrp_bom

## Source system
This table originates from Odoo ERP, indicated by the naming convention `mrp_bom` (Manufacturing Resource Planning Bill of Materials) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing and production planning process. It defines the Bill of Materials (BOM) structure, specifying which components or raw materials are required to produce a finished product or semi-finished good, including production lead times and consumption rules.

## Description
One row in this table represents a single Bill of Materials definition for a specific product or product template. It serves as a raw landed copy of the Odoo `mrp.bom` model, capturing the configuration, quantity requirements, and operational constraints for manufacturing processes within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| product_tmpl_id | INTEGER | false | Product template ID | Foreign key to the product template. |
| product_id | INTEGER | true | Specific product variant ID | Nullable if the BOM applies to all variants of the template. |
| product_uom_id | INTEGER | false | Unit of measure ID | Reference to the UoM for the produced quantity. |
| sequence | INTEGER | true | Display sequence | Used for ordering BOMs in UI/reports. |
| picking_type_id | INTEGER | true | Picking type ID | Defines the operation type for manufacturing. |
| company_id | INTEGER | true | Company ID | Multi-company context identifier. |
| produce_delay | INTEGER | true | Production delay | Lead time in days to produce the item. |
| days_to_prepare_mo | INTEGER | true | Preparation days | Lead time in days to prepare the manufacturing order. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| code | VARCHAR | true | BOM reference code | Unique identifier or internal reference string. |
| type | VARCHAR | false | BOM type | e.g., 'normal', 'phantom'. |
| ready_to_produce | VARCHAR | false | Readiness strategy | Strategy for when the MO is ready to produce. |
| consumption | VARCHAR | false | Consumption policy | Rules for component consumption (e.g., 'flexible'). |
| product_qty | NUMERIC | false | Quantity to produce | The base quantity for this BOM. |
| active | BOOLEAN | true | Active status | Soft-delete flag; false indicates archived. |
| allow_operation_dependencies | BOOLEAN | true | Dependency flag | Whether operation dependencies are enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| project_id | INTEGER | true | Project ID | Associated project for the BOM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_tmpl_id` → `product_template.id` (Likely target based on Odoo schema)
    - `product_id` → `product_product.id` (Likely target based on Odoo schema)
    - `product_uom_id` → `uom_uom.id` (Likely target based on Odoo schema)
    - `company_id` → `res_company.id` (Likely target based on Odoo schema)
- **Natural keys (inferred):** 
    - `code` (If enforced as unique by the business process)

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical analysis of archived BOMs is required.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **PII/Sensitive Data:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.
- **Data Grain:** This table defines the header-level configuration for a BOM; component details are typically stored in a related `mrp_bom_line` table (not provided here).