# web_editor_converter_test_sub

## Source system
This table originates from an Odoo ERP environment. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based default values for the primary key are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the internal configuration or content management processes of the web editor module. It appears to track sub-entities or test configurations related to web content conversion, maintaining audit trails for record creation and modification.

## Description
One row in this table represents a single configuration or sub-entity record within the web editor converter module. As a staging table, it serves as a raw, direct landing of the source system's record state, preserving the original audit metadata for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `web_editor_converter_test_sub_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's user table. |
| name | VARCHAR | true | Descriptive name or label | Content length is variable; check source for constraints. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; verify against source system timezone. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC; verify against source system timezone. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern for creator).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern for modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user directories to resolve PII.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), but Odoo often uses an `active` boolean column for this purpose; check if such a column exists in the source if records appear to be missing.
- **Data Integrity:** As a staging table, expect potential nulls in audit fields if the source system allows partial record creation.