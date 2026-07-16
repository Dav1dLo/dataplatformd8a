# phone_blacklist_remove

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in the Odoo framework, alongside the use of a sequence-based default for the `id` column.

## Functional process 
This table supports the management of a phone number suppression list, specifically tracking the removal of numbers from a blacklist. It facilitates compliance and communication preference management by recording which user initiated the removal and the justification provided for doing so.

## Description
One row in this table represents a single request or event to remove a specific phone number from a blacklist. It serves as a raw staging record capturing the audit trail of blacklist modifications, including the identity of the user performing the action and the timestamp of the event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.phone_blacklist_remove_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| phone | VARCHAR | false | The phone number being removed | Likely E.164 format; check for leading '+' or country codes. |
| reason | VARCHAR | true | Justification for removal | Free-text field describing why the number was unblocked. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC; verify against system settings. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC; verify against system settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `phone` column contains PII and should be masked or restricted according to data privacy policies (e.g., GDPR/CCPA).
- **Timestamps:** Assumed to be in UTC; confirm if the source Odoo instance is configured for a specific local timezone.
- **Soft Deletes:** This table appears to be an append-only audit log of removal events rather than a current-state table; do not expect unique constraints on `phone` across the entire history.
- **Data Quality:** The `reason` field is a free-text `VARCHAR` and may contain inconsistent or empty values.