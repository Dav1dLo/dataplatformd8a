# account_merge_wizard_line

## Source system
This table originates from an Odoo ERP system. The naming convention `account_merge_wizard_line` and the presence of `create_uid`, `write_uid`, and `display_type` columns are characteristic of Odoo's ORM-based wizard models, which manage temporary state during complex business operations.

## Functional process 
This table supports the "Customer/Account Deduplication" process. It tracks individual account records that have been identified as potential duplicates and are currently being processed within a merge wizard session to consolidate data into a single master record.

## Description
One row represents a single account record associated with a specific merge wizard session. It acts as a staging line item that tracks whether a specific account is selected for merging and how it is grouped with other potential duplicates. This is a raw landed copy of the Odoo wizard state table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `account_merge_wizard_line_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard | Links to the specific merge session instance. |
| sequence | INTEGER | true | Display order | Determines the order of accounts in the UI. |
| account_id | INTEGER | true | Reference to the account record | The actual account being evaluated for merging. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard line. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this line. |
| grouping_key | VARCHAR | true | Deduplication grouping criteria | Used to group accounts that share common attributes. |
| display_type | VARCHAR | false | UI rendering type | Defines how the line appears in the wizard interface. |
| is_selected | BOOLEAN | true | Selection flag | Indicates if the user has chosen to include this account in the merge. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `account_merge_wizard.id` (Inferred from Odoo naming conventions for wizard lines).
    - `account_id` → `res_partner.id` (Inferred; Odoo typically uses `res_partner` for account/customer entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the application server's timezone (typically UTC), but verify against the Odoo configuration.
- **Soft Deletes:** This table does not implement soft deletes; it represents transient state for a wizard session and may be truncated or cleared by the application after the merge process completes.
- **Sensitivity:** Contains user-related metadata (`create_uid`, `write_uid`) and references to customer accounts; ensure access is restricted according to internal data governance policies.
- **Data Volatility:** As a "wizard" table, data is highly transient and may only exist for the duration of a user's session.