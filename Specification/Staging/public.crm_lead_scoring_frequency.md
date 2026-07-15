# crm_lead_scoring_frequency

## Source system
This table originates from an Odoo ERP or CRM system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the specific sequence naming convention (`crm_lead_scoring_frequency_id_seq`), is characteristic of Odoo's ORM-generated audit and tracking fields.

## Functional process 
This table supports the lead scoring and conversion analysis process. It tracks the frequency of specific lead attributes (variables and their values) associated with successful ("won") and unsuccessful ("lost") sales outcomes, allowing the business to calculate conversion rates for different lead segments.

## Description
One row in this table represents a frequency count of a specific lead attribute value (e.g., a lead source or industry type) categorized by its historical win/loss performance. As a staging table, it serves as a raw, direct reflection of the Odoo database state, intended for ingestion into downstream analytical models for lead scoring optimization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_scoring_frequency_id_seq`. |
| team_id | INTEGER | true | Sales team identifier | Links to the sales team responsible for the lead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| variable | VARCHAR | true | Attribute name | The name of the lead variable being tracked. |
| value | VARCHAR | true | Attribute value | The specific value assigned to the variable. |
| won_count | NUMERIC | true | Count of won leads | Number of leads with this attribute that resulted in a win. |
| lost_count | NUMERIC | true | Count of lost leads | Number of leads with this attribute that resulted in a loss. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming convention for sales teams).
    - `create_uid` → `res_users.id` (Guess: standard Odoo naming convention for system users).
    - `write_uid` → `res_users.id` (Guess: standard Odoo naming convention for system users).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with a user directory to identify individuals.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are currently active unless otherwise specified by the source system logic.
- **Data Precision:** `won_count` and `lost_count` are `NUMERIC` types; ensure downstream casting to `INTEGER` or `BIGINT` if fractional counts are not expected.