# lot_label_layout

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the inventory and warehouse management process, specifically the configuration of label printing layouts for product lots or serial numbers. It tracks the formatting requirements and quantity settings used when generating physical labels for inventory items.

## Description
Each row represents a specific configuration profile for printing lot labels, defining the print format and the quantity of labels to be generated. As a staging table, it serves as a raw, direct ingestion of the Odoo `lot.label.layout` model, preserving the system-level audit trails for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the layout record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system users table; identifies who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system users table; identifies who last updated the record. |
| label_quantity | VARCHAR | false | Label quantity setting | Defines the number of labels to print; type is VARCHAR, likely storing a numeric string or configuration code. |
| print_format | VARCHAR | false | Print layout format | Specifies the template or format used for the label output. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone typically UTC in Odoo. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp of last record update; timezone typically UTC in Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Types:** `label_quantity` and `print_format` are stored as `VARCHAR` despite potentially containing numeric or structured data; ensure appropriate casting if performing arithmetic or joins.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are assumed to be active unless otherwise specified by business logic.
- **PII:** No sensitive PII is present in this table; it contains only system configuration and audit metadata.