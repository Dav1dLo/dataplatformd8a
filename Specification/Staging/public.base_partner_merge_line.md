# base_partner_merge_line

## Source system
This table originates from an Odoo ERP system. The naming convention `base_partner_merge_line` and the presence of `wizard_id`, `create_uid`, and `write_uid` are characteristic of Odoo's internal ORM structures, specifically those used for data deduplication and record merging wizards.

## Functional process 
This table supports the partner (customer/vendor) deduplication process. It tracks the individual lines or records involved in a merge operation initiated by a wizard, allowing the system to group multiple duplicate partner records (`aggr_ids`) into a single target record (`min_id`) during a data cleanup task.

## Description
One row in this table represents a single line item within a partner merge operation, linking a specific merge wizard session to a set of partner IDs being consolidated. As a staging table, it provides a raw, landed copy of the merge history as recorded by the Odoo application, serving as the foundation for auditing or reconstructing merge events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_partner_merge_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the merge wizard | Links to the parent merge operation record. |
| min_id | INTEGER | true | Target partner ID | The primary record ID that duplicates are being merged into. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated this merge line. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this merge line. |
| aggr_ids | VARCHAR | false | Aggregated partner IDs | A string representation of the IDs being merged; likely comma-separated. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `base_partner_merge_automatic_wizard.id` (Guess: links to the wizard session configuration).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Data Format:** The `aggr_ids` column is stored as a `VARCHAR` but contains a list of IDs; downstream consumers will need to parse this string (e.g., using `string_to_array`) to perform joins.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **PII:** While this table contains IDs, it does not contain direct PII (like names or emails), but it facilitates the mapping of records that do.
- **Soft Deletes:** Odoo typically does not use soft deletes for this type of wizard metadata; assume rows are permanent unless the application logic explicitly removes them.