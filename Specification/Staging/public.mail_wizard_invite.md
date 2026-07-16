# mail_wizard_invite

## Source system
This table originates from an Odoo ERP system. The naming convention (`mail_wizard_invite`), the use of `res_id` and `res_model` for polymorphic associations, and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal messaging and notification framework.

## Functional process 
This table supports the "Communication and Collaboration" business process, specifically tracking the state of invitation wizards used to notify users or external contacts about specific records within the system. It captures the intent to notify, the associated message content, and the target record context.

## Description
One row in this table represents a single instance of an invitation wizard session used to send notifications or messages regarding a specific record. As a staging table, it provides a raw, landed copy of the wizard's state, serving as the foundation for tracking communication history and user engagement with the notification system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.mail_wizard_invite_id_seq`. |
| res_id | INTEGER | true | ID of the related record | The specific record ID being referenced by the wizard. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| res_model | VARCHAR | false | Related model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| message | TEXT | true | Notification content | The body text of the invitation or notification. |
| notify | BOOLEAN | true | Notification flag | Indicates if the notification action was triggered. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; assume UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; assume UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Polymorphism:** The `res_id` and `res_model` columns form a polymorphic association; queries joining against this table must filter by `res_model` to ensure the `res_id` is interpreted correctly.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically deleted if removed from the source.
- **Sensitivity:** The `message` column may contain PII or internal communication content; ensure appropriate masking if exposing to non-privileged users.