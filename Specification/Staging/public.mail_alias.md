# mail_alias

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for dynamic content, and the specific sequence-based default value pattern (`nextval('"public".mail_alias_id_seq'::regclass)`).

## Functional process 
This table supports the email routing and communication management process. It defines how incoming emails are mapped to specific business objects (like tasks, leads, or support tickets) within the system, handling alias creation, thread tracking, and default routing parameters.

## Description
One row in this table represents a single email alias configuration used to route incoming messages to specific internal records. It acts as a raw landing copy of the system's email routing rules, capturing the association between an email address and its target business model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| alias_domain_id | INTEGER | true | Foreign key to domain | Links to the domain configuration. |
| alias_model_id | INTEGER | false | Target model ID | The business object type this alias routes to. |
| alias_force_thread_id | INTEGER | true | Forced thread ID | Overrides automatic thread detection. |
| alias_parent_model_id | INTEGER | true | Parent model ID | Used for hierarchical routing. |
| alias_parent_thread_id | INTEGER | true | Parent thread ID | Used for hierarchical routing. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the alias. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the alias. |
| alias_name | VARCHAR | true | Alias local part | The prefix of the email address. |
| alias_full_name | VARCHAR | true | Full alias display name | The complete email address or display string. |
| alias_contact | VARCHAR | false | Contact policy | Defines who can send to this alias. |
| alias_status | VARCHAR | true | Alias status | Current operational status of the alias. |
| alias_bounced_content | JSONB | true | Bounce details | Structured data regarding failed deliveries. |
| alias_defaults | TEXT | false | Default values | JSON-encoded string of default field values. |
| alias_incoming_local | BOOLEAN | true | Local routing flag | Indicates if the alias is for local routing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `alias_domain_id` → `mail_alias_domain.id` (Guess: standard Odoo naming pattern for domain links).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `alias_full_name` (Assuming uniqueness within the system's email routing configuration).

## Caveats for downstream consumers

- **Sensitive Data:** `alias_bounced_content` may contain PII from original email headers or body content; handle with appropriate privacy controls.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; assume records are hard-deleted if missing.
- **Data Format:** `alias_defaults` is stored as a `TEXT` field but contains serialized data (likely JSON); downstream consumers will need to parse this string to access specific default values.