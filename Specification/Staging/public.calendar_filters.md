# calendar_filters

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is highly characteristic of the Odoo ORM framework.

## Functional process 
This table supports user-specific configuration for calendar views, specifically managing which partners or resources are visible or "checked" within a user's calendar interface. It facilitates the filtering logic required to render personalized scheduling views in a multi-tenant or multi-user environment.

## Description
One row in this table represents a specific filter configuration applied by a user to a partner record within the calendar module. It serves as a raw staging entity, capturing the state of user-defined visibility settings for calendar synchronization or display.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.calendar_filters_id_seq`. |
| user_id | INTEGER | false | Foreign key to the user | Identifies the owner of the filter configuration. |
| partner_id | INTEGER | false | Foreign key to the partner | The partner record being filtered in the calendar. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this filter record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| active | BOOLEAN | true | Soft-delete flag | If false, the filter is effectively disabled. |
| partner_checked | BOOLEAN | true | Visibility toggle | Indicates if the partner is currently selected/visible. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo pattern for user ownership).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo pattern for partner references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column suggests a soft-delete pattern; queries should generally filter by `WHERE active = TRUE` unless auditing deleted configurations.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo-based systems, but verify against application settings as they may be stored in local server time.
- **PII:** While this table contains no direct PII, it links `user_id` and `partner_id`, which may be used to reconstruct user activity patterns.
- **Data Integrity:** The `create_uid` and `write_uid` columns are nullable, which may occur during bulk imports or system-level data migrations.