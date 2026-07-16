# mrp_production_backorder

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_production_backorder`), the use of `create_uid`/`write_uid` audit columns, and the standard PostgreSQL sequence pattern for the `id` column.

## Functional process 
This table supports the manufacturing execution process, specifically tracking backorders generated during production operations. It links production orders that could not be fully completed in a single run to the relevant user audit trails.

## Description
One row in this table represents a single backorder record associated with a manufacturing production order. As a staging table, it serves as a raw, direct landing of the Odoo `mrp.production.backorder` model, capturing the creation and modification metadata for each backorder event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_production_backorder_id_seq`. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the `res_users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: References the user who created the backorder record.
    - `write_uid` → `res_users.id`: References the user who last updated the backorder record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user management tables to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Integrity:** As a staging table, this may contain multiple versions of a record if the source system performs updates; check `write_date` for the most recent state.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), but Odoo models often use one; verify if rows are physically deleted or just hidden.