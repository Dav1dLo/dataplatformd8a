# utm_stage

## Source system
This table likely originates from an Odoo ERP system. The column naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based primary key are characteristic patterns of the Odoo ORM framework.

## Functional process 
This table supports the management of UTM (Urchin Tracking Module) campaign stages within a marketing or lead-tracking module. It tracks the lifecycle states of marketing campaigns, allowing users to categorize or progress campaigns through a defined workflow.

## Description
One row in this table represents a single stage definition for a UTM campaign. It serves as a raw landing copy of the stage configuration, capturing metadata about who created or modified the stage and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.utm_stage_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort stages in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system's user table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system's user table. |
| name | JSONB | false | Stage name | Likely contains localized strings; check for language keys. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed to be in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed to be in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record updates).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `create_uid` and `write_uid` link to internal user identities; ensure these are handled according to internal access policies.
- **Timestamps:** All `_date` columns are assumed to be in UTC. Verify against source system configuration if sub-second precision is required.
- **JSONB Handling:** The `name` column is stored as `JSONB`. Downstream queries will require the `->>` operator or similar to extract text values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all rows are currently active unless otherwise specified by business logic.