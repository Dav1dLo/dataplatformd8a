# project_collaborator

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of Postgres sequences for primary keys.

## Functional process 
This table supports the project management and partner relationship module, specifically tracking the association between internal projects and external partners. It manages access control and collaboration permissions for entities working on shared project tasks.

## Description
One row in this table represents a single collaboration link between a specific project and a partner. It serves as a raw landing copy of the association, capturing who created or modified the link and whether the partner has restricted access to the project.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.project_collaborator_id_seq`. |
| project_id | INTEGER | false | Foreign key to project | Identifies the project being collaborated on. |
| partner_id | INTEGER | false | Foreign key to partner | Identifies the partner entity involved. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who established this collaboration. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| limited_access | BOOLEAN | true | Access restriction flag | Indicates if the partner has restricted project visibility. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `project.id` (Inferred from standard naming convention).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo-style naming).
- **Natural keys (inferred):** 
    - `(project_id, partner_id)`: The combination of project and partner is expected to be unique for a single collaboration record.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may map to internal employee records.
- **Timezone:** Timestamps are stored in `TIMESTAMP` format; assume UTC unless the source system configuration specifies otherwise.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system logic.
- **Data Integrity:** `limited_access` is nullable; treat `NULL` as `FALSE` or "full access" depending on the application logic.