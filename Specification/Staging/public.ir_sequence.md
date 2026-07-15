# ir_sequence

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_sequence` (Internal Resource sequence) and the presence of columns like `create_uid`, `write_uid`, and `company_id` are characteristic of Odoo's internal metadata structures used to manage document numbering patterns.

## Functional process 
This table supports the document numbering and sequence generation process across the ERP. It defines the logic for generating unique identifiers for business objects such as invoices, purchase orders, or stock moves, ensuring that sequential numbering follows specific patterns (prefixes, suffixes, and padding) defined by the business.

## Description
One row in this table represents a single sequence configuration rule used to generate incrementing identifiers for business entities. It acts as a raw landed copy of the Odoo configuration table, capturing the parameters required to calculate the next available number for a given document type.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `nextval` sequence. |
| number_next | INTEGER | false | The next number to be used | Increments based on `number_increment`. |
| number_increment | INTEGER | false | Step size for the sequence | Usually defaults to 1. |
| padding | INTEGER | false | Number of digits for padding | e.g., 5 results in 00001. |
| company_id | INTEGER | true | Foreign key to company | Links sequence to a specific entity. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the sequence | Human-readable label. |
| code | VARCHAR | true | Internal code for the sequence | Used by logic to identify the sequence. |
| implementation | VARCHAR | false | Storage method | e.g., 'standard' or 'no_gap'. |
| prefix | VARCHAR | true | String prepended to the number | e.g., 'INV/'. |
| suffix | VARCHAR | true | String appended to the number | e.g., '/2023'. |
| active | BOOLEAN | true | Soft-delete flag | True if the sequence is currently in use. |
| use_date_range | BOOLEAN | true | Flag for date-based sequences | If true, sequence resets or changes by date. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Likely link to the company owning the sequence).
    - `create_uid` → `res_users.id` (Tracks the user who created the sequence).
    - `write_uid` → `res_users.id` (Tracks the user who last modified the sequence).
- **Natural keys (inferred):** 
    - `code` (In Odoo, the `code` field is typically the unique business identifier for a sequence).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical configurations are required.
- **Data Integrity:** The `number_next` column is highly volatile in an operational system; downstream analytics should treat this as a configuration snapshot rather than a real-time counter.