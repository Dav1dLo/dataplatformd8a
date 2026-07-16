# validate_account_move

## Source system
This table originates from an Odoo ERP system. The naming convention (`validate_account_move`), the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of `nextval` sequences are characteristic of Odoo's ORM-managed PostgreSQL database schema.

## Functional process 
This table supports the financial accounting module's validation workflow, specifically the "Account Move" posting process. It acts as a transient or configuration-heavy staging object used to capture parameters (such as `force_post` or `ignore_abnormal_date`) when a user or automated process triggers the validation of accounting journal entries.

## Description
One row in this table represents a single validation request or configuration state for an accounting journal entry move. It serves as a raw landed copy of the validation parameters used during the posting of financial transactions within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the users table. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the users table. |
| force_post | BOOLEAN | true | Flag to bypass validation checks | If true, forces the posting of the move. |
| ignore_abnormal_date | BOOLEAN | true | Flag to suppress date warnings | Allows posting despite abnormal dates. |
| ignore_abnormal_amount | BOOLEAN | true | Flag to suppress amount warnings | Allows posting despite abnormal amounts. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are permanent unless an `active` column is added in future schema versions.
- **Data Pattern:** As a staging table, this data may be truncated and reloaded or contain transient state; verify if this is intended for long-term historical analysis.