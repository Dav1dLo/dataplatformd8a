# pos_hr_advanced_employee_hr_employee

## Source system
This table likely originates from an Odoo ERP system, specifically the Point of Sale (POS) module. The naming convention `pos_hr_advanced_employee` is characteristic of Odoo's internal module structures, which link human resource records to point-of-sale configurations.

## Functional process 
This table supports the POS-HR integration process, specifically managing the mapping between POS configurations and authorized employees. It facilitates access control and shift tracking by defining which employees are permitted to operate specific point-of-sale terminals.

## Description
One row represents a single association between a specific POS configuration and an employee. It serves as a raw landing junction table in the staging layer, enabling the system to verify employee permissions at the point of sale.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Represents the specific terminal or shop setup. |
| hr_employee_id | INTEGER | false | Foreign key to the HR employee record | Identifies the employee authorized for the configuration. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(pos_config_id, hr_employee_id)`.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column links to the configuration settings for a POS terminal.
    - `hr_employee_id` → `hr_employee.id`: This column links to the master employee record in the HR module.
- **Natural keys (inferred):** The combination of `(pos_config_id, hr_employee_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships between employees and POS configurations.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present in this schema, making it difficult to track the history of these associations.
- The table contains no PII directly, but it links sensitive employee IDs to operational POS configurations.