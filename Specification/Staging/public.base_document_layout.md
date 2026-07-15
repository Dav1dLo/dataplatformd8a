# base_document_layout

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the presence of `company_id` and `report_layout_id` are characteristic of Odoo's base ORM structure for managing document templates and report configurations.

## Functional process 
This table supports the document management and reporting configuration process. It tracks the association between companies and specific document layouts, likely used to determine which header/footer or styling template is applied when generating invoices or other business documents.

## Description
One row in this table represents a specific document layout configuration assigned to a company. It serves as a raw landed staging entity, capturing the metadata and audit trail for document template assignments within the ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `base_document_layout_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Links the layout to a specific business entity. |
| report_layout_id | INTEGER | true | Foreign key to report layout | Reference to the specific template or style definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |
| from_invoice | BOOLEAN | true | Invoice source flag | Indicates if the layout is specifically associated with invoice generation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `report_layout_id` → `ir_actions_report.id` (Likely reference to report action definitions).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are typically stored in the server's local time; verify the Odoo instance timezone configuration.
- This table does not implement soft deletes; records are typically hard-deleted in this layer unless the source system implements a specific `active` boolean column (not present here).
- `create_uid` and `write_uid` refer to internal system user IDs and should be joined against the `res_users` table for human-readable names.
- The `from_invoice` flag is a boolean; treat `NULL` values as `FALSE` in downstream logic if the business process assumes a default state.