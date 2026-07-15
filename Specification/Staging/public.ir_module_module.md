# ir_module_module

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_module_module` is characteristic of Odoo's internal registry (the "ir" prefix stands for "internal registry"), which tracks installed and available software modules within the application environment.

## Functional process 
This table supports the module management and lifecycle process within the Odoo platform. It tracks the installation state, versioning, and metadata of various functional modules (e.g., Sales, Inventory, Accounting) that extend the core ERP functionality.

## Description
One row in this table represents a single software module registered within the Odoo instance. It captures the module's identity, current installation state, versioning information, and descriptive metadata. This table serves as a raw landed copy of the system's module registry, used to audit which features are active or available for configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| website | VARCHAR | true | Module website URL | |
| summary | JSONB | true | Short summary of module | Localized content. |
| name | VARCHAR | false | Technical module name | Unique identifier for the module. |
| author | VARCHAR | true | Module author name | |
| icon | VARCHAR | true | Path to module icon | |
| state | VARCHAR(16) | true | Installation state | e.g., 'installed', 'uninstalled', 'to upgrade'. |
| latest_version | VARCHAR | true | Current version string | |
| shortdesc | JSONB | true | Short description | Localized content. |
| category_id | INTEGER | true | Category ID | References `ir_module_category`. |
| description | JSONB | true | Full module description | Localized content. |
| application | BOOLEAN | true | Is an application | Flag for top-level apps. |
| demo | BOOLEAN | true | Contains demo data | |
| web | BOOLEAN | true | Is a web module | |
| license | VARCHAR(32) | true | License type | e.g., 'LGPL-3', 'OPL-1'. |
| sequence | INTEGER | true | Display order sequence | |
| auto_install | BOOLEAN | true | Auto-install flag | |
| to_buy | BOOLEAN | true | Purchase required flag | |
| maintainer | VARCHAR | true | Module maintainer | |
| published_version | VARCHAR | true | Published version | |
| url | VARCHAR | true | Documentation URL | |
| contributors | TEXT | true | List of contributors | |
| menus_by_module | TEXT | true | Associated menu definitions | |
| reports_by_module | TEXT | true | Associated report definitions | |
| views_by_module | TEXT | true | Associated view definitions | |
| module_type | VARCHAR | true | Type of module | |
| imported | BOOLEAN | true | Imported flag | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit field pattern)
    - `category_id` → `ir_module_category.id` (Categorization of modules)
- **Natural keys (inferred):** 
    - `name` (The technical name is unique across the Odoo module registry)

## Caveats for downstream consumers

- **Sensitive Data:** Contains no PII, but `JSONB` fields may contain large amounts of text that require careful parsing.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically does not use soft deletes for this table; records are generally persistent as long as the module is registered.
- **JSONB:** The `summary`, `shortdesc`, and `description` columns contain JSONB data, which often stores multi-language strings (e.g., `{"en_US": "...", "fr_FR": "..."}`). Ensure your query logic handles the specific language keys required.