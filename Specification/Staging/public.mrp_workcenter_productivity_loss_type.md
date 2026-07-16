# mrp_workcenter_productivity_loss_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_workcenter_...`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing execution process by defining the categories or "reasons" for productivity losses at work centers. It is used within the production tracking module to classify downtime or efficiency gaps, allowing managers to report on why manufacturing equipment is not meeting output targets.

## Description
One row represents a single defined category of productivity loss that can be assigned to a work center event. This is a reference/lookup table in the staging layer, providing the descriptive labels used to categorize operational inefficiencies in the manufacturing pipeline.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the loss type. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated this record. |
| loss_type | VARCHAR | false | Loss category label | The descriptive name or code for the productivity loss. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system at the time of record insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system at the time of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `loss_type` (Assuming the business logic enforces unique names for loss categories).

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user accounts; these should be masked if exposing data to non-admin roles.
- **Timestamps:** Timestamps are stored in the database's local time (typically UTC in Odoo deployments); verify against the source server configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically deleted if removed from the source.
- **Data Integrity:** `loss_type` is the primary business descriptor; ensure downstream joins handle potential variations in string casing if the source does not enforce strict normalization.