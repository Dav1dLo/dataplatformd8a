# digest_tip

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences and `JSONB` fields for localized content, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the "Digest" or "Email Marketing" notification system, specifically managing the content of "tips" or informational snippets included in automated digest emails sent to users. It tracks the sequence and grouping of these tips, likely used to populate periodic performance or feature-update summaries.

## Description
One row in this table represents a single informational tip or content snippet intended for inclusion in a digest communication. It serves as a raw staging entity, capturing the localized content (stored as JSONB) and audit metadata for each tip record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.digest_tip_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort tips within a digest. |
| group_id | INTEGER | true | Foreign key to digest group | Links the tip to a specific digest category. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | JSONB | true | Tip title | Likely contains multi-language strings. |
| tip_description | JSONB | true | Tip body content | Likely contains multi-language HTML/text. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `group_id` → `digest_tip_group.id` (Guess: links to the parent grouping entity).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit link).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Content:** The `name` and `tip_description` columns contain JSONB data. Downstream queries will need to use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage practices.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these may not map to external-facing user identifiers without joining against the `res_users` table.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all rows are active unless otherwise specified by business logic.