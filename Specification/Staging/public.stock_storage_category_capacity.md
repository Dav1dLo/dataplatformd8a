# stock_storage_category_capacity

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` on a `_seq` sequence for the primary key, is characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports inventory management and warehouse operations, specifically tracking the capacity or stock levels allocated to specific storage categories. It links products and package types to storage categories to define how much of a specific item can be housed within a given storage classification.

## Description
One row in this table represents a specific capacity configuration or stock allocation record for a storage category, optionally filtered by product or package type. As a staging table, it serves as a raw, direct landing of the operational database records, intended to be used for downstream inventory reporting and warehouse optimization analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| storage_category_id | INTEGER | false | Foreign key to storage category | Identifies the storage location or category. |
| product_id | INTEGER | true | Foreign key to product | Optional; restricts capacity to a specific product. |
| package_type_id | INTEGER | true | Foreign key to package type | Optional; restricts capacity to a specific packaging. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| quantity | DOUBLE PRECISION | false | Capacity or stock quantity | The numerical limit or current stock count. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `storage_category_id` → `stock_storage_category.id` (Inferred from naming convention)
    - `product_id` → `product_product.id` (Inferred from naming convention)
    - `package_type_id` → `stock_package_type.id` (Inferred from naming convention)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against source system configuration if time-zone precision is critical.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; check if the source system uses a separate mechanism for logical deletion.
- **Nullability:** `product_id` and `package_type_id` are nullable, implying that some capacity records may be generic (applying to all products/packages) rather than specific.
- **Data Integrity:** As a staging table, ensure that downstream joins handle potential orphans if the source system does not enforce strict referential integrity.