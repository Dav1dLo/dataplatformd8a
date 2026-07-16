# stock_putaway_rule

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_putaway_rule`), the use of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based primary key pattern.

## Functional process 
This table supports the warehouse management (WMS) putaway strategy process. It defines the logic for where products or product categories should be automatically moved (put away) when they arrive at a specific input location (`location_in_id`), directing them to a destination storage location (`location_out_id`).

## Description
One row represents a single putaway rule configuration that dictates the automated routing of inventory from an incoming location to a specific storage location. This is a raw landed copy of the Odoo configuration table, serving as the staging entity for warehouse routing logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_putaway_rule_id_seq`. |
| product_id | INTEGER | true | Foreign key to product | Defines the specific product this rule applies to. |
| category_id | INTEGER | true | Foreign key to product category | Defines the product category this rule applies to. |
| location_in_id | INTEGER | false | Foreign key to source location | The location where the product is received. |
| location_out_id | INTEGER | false | Foreign key to destination location | The location where the product should be moved. |
| sequence | INTEGER | true | Priority order | Determines the order in which rules are evaluated. |
| company_id | INTEGER | false | Foreign key to company | Multi-company scope identifier. |
| storage_category_id | INTEGER | true | Foreign key to storage category | Links to specific storage capacity/type rules. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Audit: user who last updated the rule. |
| sublocation | VARCHAR | true | Sub-location identifier | Optional string identifier for specific sub-bins. |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the system. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit: record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit: record last modification time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `product_id` → `product_product.id` (Guess: standard Odoo product link)
    - `category_id` → `product_category.id` (Guess: standard Odoo category link)
    - `location_in_id` → `stock_location.id` (Guess: standard Odoo location link)
    - `location_out_id` → `stock_location.id` (Guess: standard Odoo location link)
    - `company_id` → `res_company.id` (Guess: standard Odoo company link)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal routing logic.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless auditing historical configurations.
- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments, but verify against system configuration).
- **PII/Sensitivity:** Contains no PII; however, it exposes internal warehouse layout and operational logic.
- **Nullability:** `product_id` and `category_id` are both nullable, implying a rule might apply to a whole category or a specific product, but rarely both simultaneously.