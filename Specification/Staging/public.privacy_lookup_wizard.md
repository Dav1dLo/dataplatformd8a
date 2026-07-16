# privacy_lookup_wizard

## Source system
The table appears to originate from an Odoo ERP or a similar Python-based framework application. This is inferred from the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default value for the primary key, which is characteristic of the Odoo ORM.

## Functional process 
This table supports a data privacy or GDPR compliance workflow, likely acting as a staging area for "Right to be Forgotten" or "Data Subject Access Request" (DSAR) lookups. The `execution_details` column suggests it tracks the progress or results of a search for a specific user's data across the system.

## Description
Each row represents a single privacy lookup request initiated by a system user to identify or process personal data associated with a specific email address. As a staging table, it serves as a raw landing point for these requests before they are processed or audited by downstream compliance modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `privacy_lookup_wizard_id_seq`. |
| log_id | INTEGER | true | Reference to an external log entry | Likely links to a broader system audit log. |
| create_uid | INTEGER | true | ID of the user who created the request | Foreign key to a users table. |
| write_uid | INTEGER | true | ID of the user who last modified the request | Foreign key to a users table. |
| name | VARCHAR | false | Name of the data subject or request | |
| email | VARCHAR | false | Email address of the data subject | PII; requires masking in downstream reporting. |
| execution_details | TEXT | true | JSON or log output of the lookup process | May contain unstructured diagnostic data. |
| create_date | TIMESTAMP | true | Timestamp of request creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** 
    - `email` (In the context of a privacy lookup, the email is the unique identifier for the data subject).

## Caveats for downstream consumers

- **PII:** The `email` column contains sensitive personal information and must be handled according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC; verify against application server settings if precision is required for audit trails.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are current unless otherwise specified by the source system logic.
- **Data Quality:** `execution_details` is a `TEXT` field and may contain varying formats (e.g., serialized JSON or plain text logs) depending on the wizard's execution state.