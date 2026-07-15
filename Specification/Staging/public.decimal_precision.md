# decimal_precision

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is characteristic of the Odoo ORM metadata pattern.

## Functional process 
This table supports the configuration of numerical precision settings across the ERP. It defines the number of decimal places allowed for various currency or unit-of-measure fields throughout the application, ensuring consistent rounding behavior in financial and inventory calculations.

## Description
One row in this table represents a specific decimal precision configuration rule, defining the number of digits allowed for a named numerical field or category. As a staging table, it provides a raw, direct copy of the configuration metadata from the source database, intended for use in downstream transformation layers to enforce rounding logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the precision rule. |
| digits | INTEGER | false | Number of decimal places | The scale applied to the associated numerical field. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated this record. |
| name | VARCHAR | false | Precision rule name | Descriptive label for the precision setting (e.g., 'Account', 'Product Price'). |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `name` (The name of the precision rule is typically unique within the system).

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to contain a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Data Precision:** The `name` column is defined as `VARCHAR` without a specified length; downstream systems should handle variable-length strings accordingly.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created via system migration or direct database injection rather than the application UI.