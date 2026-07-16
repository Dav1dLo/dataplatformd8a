# res_lang

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_lang` (Resource Language) and the presence of audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of Odoo's core ORM structure for managing system-wide configuration data.

## Functional process 
This table supports the localization and internationalization (i18n) process within the ERP. It defines the available languages for the user interface, document generation, and data formatting, ensuring that dates, times, and numeric values are rendered according to regional standards.

## Description
One row in this table represents a single language configuration available within the system. It acts as a raw landed copy of the Odoo `res.lang` model, providing the necessary metadata for formatting locale-specific data across the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| name | VARCHAR | false | Full name of the language | e.g., "English (US)". |
| code | VARCHAR | false | Language code | e.g., "en_US". |
| iso_code | VARCHAR | true | ISO 639-1/2 language code | Optional; used for external mapping. |
| url_code | VARCHAR | false | URL-friendly language identifier | Used in web routing. |
| direction | VARCHAR | false | Text direction | Usually "ltr" or "rtl". |
| date_format | VARCHAR | false | Date format string | Odoo/Python strftime format. |
| time_format | VARCHAR | false | Time format string | Odoo/Python strftime format. |
| short_time_format | VARCHAR | false | Short time format string | Used for compact UI displays. |
| week_start | VARCHAR | false | First day of the week | e.g., "7" for Sunday. |
| grouping | VARCHAR | false | Numeric grouping format | Defines digit separation. |
| decimal_point | VARCHAR | false | Decimal separator character | e.g., "." or ",". |
| thousands_sep | VARCHAR | true | Thousands separator character | e.g., "," or ".". |
| active | BOOLEAN | true | Soft-delete flag | If false, language is hidden in UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard audit patterns).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard audit patterns).
- **Natural keys (inferred):** 
    - `code` (The unique language identifier, e.g., 'en_US').

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical audit is required.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with Odoo's internal architecture.
- **Formatting:** The format strings (`date_format`, `time_format`) follow Python's `strftime` syntax, which may require translation if consumed by non-Python reporting tools.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo lengths (typically 64-255 characters) but verify if building strict schema constraints.