# res_partner_industry

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_partner_industry` and the presence of `create_uid`, `write_uid`, and `JSONB` fields for multi-language support are characteristic of the Odoo ORM's underlying PostgreSQL schema.

## Functional process 
This table supports the Customer Relationship Management (CRM) and Partner Management modules by categorizing business partners (companies) into specific industries. It provides a standardized list of industry classifications used to enrich partner profiles for reporting and segmentation purposes.

## Description
One row in this table represents a single industry classification available for assignment to business partners. This is a raw landed copy of the Odoo configuration table, serving as a reference dimension for downstream staging models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_partner_industry_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| name | JSONB | true | Short industry name | Multi-language support; usually contains the primary language string. |
| full_name | JSONB | true | Full industry name | Multi-language support; often includes descriptive details. |
| active | BOOLEAN | true | Soft-delete flag | If false, the industry is hidden from UI selection. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Tracks the creator of the record.
    - `write_uid` → `res_users.id`: Tracks the last modifier of the record.
- **Natural keys (inferred):** 
    - `name`: While stored as JSONB, the industry name acts as the business identifier for the classification.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `full_name` columns contain JSON objects (e.g., `{"en_US": "Technology", "fr_FR": "Technologie"}`). Queries must use the `->>` operator to extract specific language values.
- **Timezone:** Timestamps are stored as `TIMESTAMP` (without time zone); they are typically stored in UTC by the Odoo application layer.
- **Soft Deletes:** The `active` column should be filtered (`WHERE active = true`) to exclude deprecated industry classifications from reporting.
- **PII:** This table contains no PII; it is a reference/configuration table.