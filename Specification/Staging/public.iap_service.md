# iap_service

## Source system
This table originates from an Odoo ERP environment. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences and `JSONB` fields for multi-language support, is characteristic of the Odoo framework's internal metadata and service definition structures.

## Functional process 
This table supports the In-App Purchase (IAP) service management process. It acts as a registry for available IAP services (e.g., credit-based services like SMS, OCR, or document signing) that the ERP instance can interact with, defining how these services are named, described, and how their balances are tracked.

## Description
One row represents a single IAP service definition available to the platform. It serves as a raw landed copy of the service configuration, capturing metadata such as the service's technical identifier, human-readable names, and balance handling logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `iap_service_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| name | VARCHAR | false | Display name of the service | Likely contains localized string data. |
| technical_name | VARCHAR | false | Internal system identifier | Used for API calls or service routing. |
| description | JSONB | false | Service description | Expected to contain multi-language JSON blobs. |
| unit_name | JSONB | false | Unit of measure for the service | Expected to contain multi-language JSON blobs. |
| integer_balance | BOOLEAN | false | Balance type flag | If true, service uses whole units; if false, fractional. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `technical_name` (This serves as the unique business identifier for the service).

## Caveats for downstream consumers

- **JSONB Content:** The `description` and `unit_name` columns contain JSONB data. Downstream consumers will need to use PostgreSQL JSON operators (e.g., `->>`) to extract specific language values.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created via system migration or direct database injection.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by business logic.