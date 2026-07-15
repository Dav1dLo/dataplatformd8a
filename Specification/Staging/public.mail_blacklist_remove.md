# mail_blacklist_remove

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the email marketing and communication management process. It tracks the removal of email addresses from a blacklist, allowing previously unsubscribed or blocked contacts to be reinstated for future communications.

## Description
One row in this table represents a single request or event to remove an email address from the system's blacklist. It serves as a staging record capturing the audit trail of who performed the removal, when it occurred, and the justification provided for the action.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_blacklist_remove_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| email | VARCHAR | false | Email address to be removed from blacklist | Likely contains PII. |
| reason | VARCHAR | true | Justification for removal | Free-text field. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `email` (In the context of a blacklist removal, the email address acts as the business identifier for the entity being processed).

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information and should be masked or handled according to data privacy policies.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** This table represents a transactional log of removal events; it does not necessarily represent the current state of the blacklist itself.
- **Soft Deletes:** There is no explicit soft-delete flag; records are assumed to be immutable once created, with updates tracked via `write_date`.