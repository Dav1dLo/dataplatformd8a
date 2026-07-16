# rating_rating

## Source system
This table originates from Odoo ERP. The naming convention (`res_model`, `res_id`, `partner_id`, `create_uid`) and the specific sequence generator pattern (`nextval('"public".rating_rating_id_seq'::regclass)`) are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the Customer Feedback and Satisfaction tracking process. It captures qualitative and quantitative ratings linked to various business objects (e.g., tasks, tickets, or projects) within the Odoo ecosystem, allowing the business to measure service performance and customer sentiment.

## Description
One row represents a single rating event submitted by a partner or user regarding a specific business record. This is a raw landed staging table containing the full history of feedback entries, including the associated metadata, textual feedback, and internal processing flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| res_model_id | INTEGER | true | ID of the related model | Links to the ir.model table. |
| res_id | INTEGER | false | ID of the rated record | The specific object being rated. |
| parent_res_model_id | INTEGER | true | ID of the parent model | Used for hierarchical record structures. |
| parent_res_id | INTEGER | true | ID of the parent record | The parent object ID. |
| rated_partner_id | INTEGER | true | ID of the partner being rated | The entity receiving the feedback. |
| partner_id | INTEGER | true | ID of the partner providing feedback | The author of the rating. |
| message_id | INTEGER | true | ID of the related mail message | Links to mail.message. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| res_name | VARCHAR | true | Name of the rated record | Denormalized display name. |
| res_model | VARCHAR | true | Technical name of the model | e.g., 'project.task'. |
| parent_res_name | VARCHAR | true | Name of the parent record | Denormalized display name. |
| parent_res_model | VARCHAR | true | Technical name of the parent model | e.g., 'project.project'. |
| rating_text | VARCHAR | true | Categorical rating label | e.g., 'top', 'ok', 'bad'. |
| access_token | VARCHAR | true | Security token for external access | Used for public rating links. |
| feedback | TEXT | true | Qualitative feedback text | The user's written comments. |
| is_internal | BOOLEAN | true | Internal-only flag | Indicates if the rating is for internal use. |
| consumed | BOOLEAN | true | Consumption status | Indicates if the rating has been processed. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| rating | DOUBLE PRECISION | true | Numerical rating value | Usually a scale (e.g., 1-5 or 1-10). |
| publisher_id | INTEGER | true | ID of the publisher | The entity publishing the rating. |
| publisher_comment | TEXT | true | Publisher's response | Official response to the feedback. |
| publisher_datetime | TIMESTAMP | true | Publication timestamp | When the response was published. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `partner_id` → `res_partner.id` (Likely target: the partner who provided the rating)
    - `rated_partner_id` → `res_partner.id` (Likely target: the partner being evaluated)
    - `create_uid` → `res_users.id` (Likely target: the user who created the record)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `feedback` and `publisher_comment` columns may contain PII or sensitive customer complaints; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** `res_model` and `res_id` form a polymorphic relationship; queries joining this table must filter by `res_model` to ensure correct record resolution.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all rows are active unless otherwise specified by Odoo business logic.