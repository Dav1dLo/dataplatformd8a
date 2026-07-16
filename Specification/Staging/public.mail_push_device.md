# mail_push_device

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`partner_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the push notification infrastructure for mobile or web clients. It manages the registration of device endpoints and their associated security keys, allowing the system to route push notifications to specific partners (users).

## Description
One row in this table represents a single registered push notification device associated with a specific partner. It serves as a raw landing copy of the device registration state, capturing the endpoint URL, encryption keys, and expiration metadata required for push service communication.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_push_device_id_seq`. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the user/partner owning the device. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who registered the device. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| endpoint | VARCHAR | false | Push service endpoint URL | The destination URL for push notifications. |
| keys | VARCHAR | false | Encryption keys | JSON or encoded string containing auth/p256dh keys. |
| expiration_time | TIMESTAMP | true | Token expiration | Timestamp when the push subscription expires. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo pattern for linking records to a partner).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** 
    - `endpoint` (Assuming the endpoint URL is unique per device registration).

## Caveats for downstream consumers

- **Sensitive Data:** The `keys` column contains security credentials for push notifications and should be masked or restricted in downstream reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed physically if the subscription is revoked.
- **Data Quality:** The `keys` column is stored as a `VARCHAR` but likely contains structured JSON; downstream consumers may need to parse this content.