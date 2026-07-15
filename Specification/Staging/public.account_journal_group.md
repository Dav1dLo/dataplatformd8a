# account_journal_group

## Source system
This table originates from an Odoo ERP system. The presence of columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the `JSONB` type for the `name` field and the sequence-based default for the `id`, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the financial accounting module, specifically the grouping of journals for reporting or organizational purposes. It allows users to categorize multiple accounting journals under a single parent group, facilitating consolidated views in financial statements and ledger reporting.

## Description
One row in this table represents a single journal group entity used to aggregate accounting journals. This is a raw landed copy of the staging data, serving as the foundation for downstream transformations into financial reporting dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_journal_group_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links the group to a specific legal entity. |
| sequence | INTEGER | true | Display order index | Used to determine the sort order in UI/reports. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | JSONB | false | Group name | Multi-language support via JSONB structure. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified, though `create_uid` and `write_uid` link to user identities.
- **Timestamps:** Assumed to be in UTC, as is standard for Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless filtered by business logic.
- **JSONB:** The `name` column contains structured data; ensure your downstream SQL uses the `->>` operator to extract text values (e.g., `name->>'en_US'`).