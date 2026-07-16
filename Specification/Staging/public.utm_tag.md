# utm_tag

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the use of `nextval` sequences and `JSONB` for localized fields, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the marketing attribution and campaign tracking process. It serves as a registry for UTM tags used to categorize and track the performance of marketing campaigns, likely linked to lead generation or website traffic analysis modules within the ERP.

## Description
One row in this table represents a single UTM tag definition used for tracking marketing campaign parameters. It acts as a raw landed copy of the Odoo `utm.tag` model, capturing the metadata and audit history for each tag.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.utm_tag_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual categorization in the Odoo backend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | JSONB | false | Tag name | Stores the tag label; often contains multi-language support via JSON keys. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone is typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone is typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Likely references the system user who performed the creation.
    - `write_uid` → `res_users.id`: Likely references the system user who performed the last update.
- **Natural keys (inferred):** 
    - `name`: While stored as JSONB, the tag name is intended to be the unique business identifier for the UTM category.

## Caveats for downstream consumers

- **PII/Sensitivity:** None identified; this table contains operational metadata for marketing tags.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **JSONB Usage:** The `name` column is a `JSONB` object. Downstream consumers will need to extract the specific language key (e.g., `name->>'en_US'`) to use the tag label in reports.