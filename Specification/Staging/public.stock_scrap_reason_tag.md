# stock_scrap_reason_tag

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized fields, and the sequence-based primary key pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the inventory management and quality control process by providing a categorized tagging system for stock scrap reasons. It allows warehouse operators to label why inventory was scrapped (e.g., damaged, expired, obsolete) for reporting and audit purposes.

## Description
One row in this table represents a single scrap reason tag used to classify inventory write-offs. This is a raw landed staging table containing the configuration metadata for these tags, including localized names and UI display properties.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| sequence | INTEGER | true | Display order index | Used to sort tags in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the tag. |
| write_uid | INTEGER | true | Last updater user ID | Foreign key to the system user who last modified the tag. |
| color | VARCHAR | true | UI color code | Represents the color associated with the tag in the application. |
| name | JSONB | false | Localized tag name | Contains the tag name in multiple languages; structure depends on Odoo's translation format. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user table).
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, it is stored as `JSONB` and may not be unique across all locales.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains localized strings. Downstream consumers must use PostgreSQL JSONB operators (e.g., `name->>'en_US'`) to extract readable values.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless Odoo's standard `active` column is missing from this specific landing.
- **Data Integrity:** As a staging table, this may contain historical configuration states; ensure you filter for the latest `write_date` if performing deduplication.