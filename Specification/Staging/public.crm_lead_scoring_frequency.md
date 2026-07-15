# crm_lead_scoring_frequency

## Source system
This table originates from an Odoo ERP or CRM system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the specific sequence naming convention (`crm_lead_scoring_frequency_id_seq`), is characteristic of Odoo's ORM-managed PostgreSQL schema.

## Functional process 
This table supports the lead scoring and conversion analysis process. It tracks the frequency of specific lead attributes (variables) associated with successful ("won") and unsuccessful ("lost") outcomes, likely used to calculate the probability of conversion for incoming leads.

## Description
One row in this table represents a statistical observation of a specific lead attribute value and its associated win/loss counts. As a staging table, it serves as a raw, direct reflection of the Odoo database state, intended for ingestion into downstream analytical models for lead scoring optimization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `crm_lead_scoring_frequency_id_seq`. |
| team_id | INTEGER | true | Foreign key to the sales team | Links the record to a specific organizational unit. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| variable | VARCHAR | true | The lead attribute being measured | e.g., "source", "industry", or "campaign". |
| value | VARCHAR | true | The specific value of the variable | e.g., "email", "referral", or "web". |
| won_count | NUMERIC | true | Number of won leads with this attribute | Represents successful conversion frequency. |
| lost_count | NUMERIC | true | Number of lost leads with this attribute | Represents unsuccessful conversion frequency. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming for sales teams).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** 
    - `(team_id, variable, value)`: Likely represents the unique business grain for this frequency metric.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to identify specific employees.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Integrity:** `won_count` and `lost_count` are stored as `NUMERIC`; ensure casting to `INTEGER` or `BIGINT` if performing arithmetic in downstream SQL.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.