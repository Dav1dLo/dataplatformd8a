# pos_note

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default value for the primary key.

## Functional process 
This table supports the management of point-of-sale (POS) notes or annotations. It likely stores descriptive text or metadata associated with POS transactions or sessions, providing a mechanism for staff to attach comments or specific identifiers to records within the retail workflow.

## Description
One row in this table represents a single note or annotation entry within the point-of-sale system. It serves as a raw landed copy of the source system's note entity, capturing the content of the note along with its creation and modification audit trail.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.pos_note_id_seq` for auto-increment. |
| sequence | INTEGER | true | Display order or priority | Used to sort notes in the UI. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| name | VARCHAR | false | The content of the note | The primary text field for the note. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; verify against source system settings. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; verify against source system settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in `TIMESTAMP` format; assume UTC unless the source Odoo instance is configured otherwise.
- **Audit Columns:** `create_uid` and `write_uid` are integers referencing an external user table that may not be present in this staging schema.
- **Data Integrity:** The `name` column is mandatory, but there are no constraints preventing duplicate note content.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` or `is_deleted`); assume all rows are current unless otherwise specified by the source system logic.