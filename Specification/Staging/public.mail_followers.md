# mail_followers

## Source system
This table originates from an Odoo ERP system. The naming convention (`mail_followers`, `res_id`, `res_model`, `partner_id`) is characteristic of the Odoo framework's messaging and notification architecture, which tracks which partners (users or contacts) are following specific records across various modules.

## Functional process 
This table supports the notification and subscription management process. It tracks the relationship between business entities (e.g., tasks, sales orders, or project issues) and the partners who have subscribed to receive updates or notifications regarding those specific records.

## Description
One row represents a single subscription link between a specific business record and a partner. It acts as a junction table in the staging layer, providing a raw, un-transformed view of the follower registry used by the Odoo mail system to route communications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| res_id | INTEGER | true | Resource ID | The ID of the record being followed in the source model. |
| partner_id | INTEGER | false | Partner ID | Foreign key to the partner/contact registry. |
| res_model | VARCHAR | false | Resource Model | The technical name of the Odoo model (e.g., 'project.task'). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred based on standard Odoo schema conventions).
- **Natural keys (inferred):** 
    - (`res_model`, `res_id`, `partner_id`) — This combination represents the unique business constraint preventing duplicate subscriptions for the same entity.

## Caveats for downstream consumers

- **PII:** The `partner_id` links to contact information; ensure appropriate access controls are applied when joining with partner tables.
- **Data Integrity:** `res_id` is nullable, which may occur if a follower is attached to a model generally rather than a specific record instance.
- **Model Polymorphism:** The `res_model` column is a string identifier; queries must filter by specific model names (e.g., `WHERE res_model = 'project.task'`) to avoid cross-module join errors.
- **Soft Deletes:** This table does not contain explicit audit or soft-delete flags; assume rows are removed physically upon unfollowing.