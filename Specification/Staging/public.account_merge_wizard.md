# account_merge_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`_wizard`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of Postgres sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the data cleansing and deduplication process within the CRM or Sales module. It tracks the state and configuration of "merge wizard" sessions, which are used by users to identify and merge duplicate account or partner records into a single master record.

## Description
One row represents a single execution instance or configuration state of an account merge operation initiated by a user. It acts as a staging record for the wizard's parameters, capturing who performed the action and the specific grouping logic applied during the merge process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system's internal user table. |
| is_group_by_name | BOOLEAN | true | Flag for grouping logic | Indicates if the merge wizard is configured to group potential duplicates by name. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in UTC in Odoo-based systems, but verify against the application server configuration.
- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure appropriate access controls are applied if joining with user metadata.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag, suggesting it may store historical logs of merge operations rather than just active state.
- **Data Integrity:** As a "wizard" table, rows may be transient or ephemeral depending on the application's cleanup policy for completed merge sessions.