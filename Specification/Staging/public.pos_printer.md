# pos_printer

## Source system
This table originates from an Odoo ERP system, as evidenced by the standard Odoo naming conventions for audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based primary key (`nextval('"public".pos_printer_id_seq'::regclass)`).

## Functional process 
This table supports the Point of Sale (POS) hardware configuration process. It manages the registry of physical or network-attached printers assigned to specific company entities, enabling the POS system to route receipts and order tickets to the correct hardware via proxy IPs or direct IP connections.

## Description
One row in this table represents a single printer configuration record linked to a company. It serves as a raw landed copy of the printer registry from the source ERP, used to map POS terminals to physical output devices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `pos_printer_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Links the printer to a specific business entity. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| name | VARCHAR | false | Printer display name | Human-readable identifier for the printer. |
| printer_type | VARCHAR | true | Type of printer connection | e.g., 'epson_epos', 'network', 'usb'. |
| proxy_ip | VARCHAR | true | IP address of the IoT proxy | The network address of the hardware proxy server. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| epson_printer_ip | VARCHAR | true | Direct IP for Epson printers | Used if the printer is connected directly via network. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag; however, Odoo tables typically use `active` boolean columns for logical deletion, which is absent here.
- `printer_type` and `proxy_ip` may contain varying formats depending on the specific hardware integration used in the source system.
- No PII is immediately obvious, but `name` fields should be reviewed for potential sensitive internal naming conventions.