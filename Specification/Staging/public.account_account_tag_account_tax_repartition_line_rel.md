# account_account_tag_account_tax_repartition_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_tax_repartition_line` and `account_account_tag` is characteristic of Odoo's many-to-many join tables, which are automatically generated to link tax repartition lines to account tags for financial reporting and tax configuration.

## Functional process 
This table supports the tax configuration and financial reporting process. It facilitates the many-to-many relationship between tax repartition lines (which define how tax amounts are distributed across accounts) and account tags (used for grouping accounts for tax reports or analytical purposes).

## Description
One row in this table represents a single association between a specific tax repartition line and an account tag. It serves as a raw junction table in the staging layer, enabling the resolution of many-to-many relationships between tax definitions and account classification tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_tax_repartition_line_id | INTEGER | false | Foreign key to the tax repartition line | Links to the primary key of the tax repartition line table. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag | Links to the primary key of the account tag table. |

## Keys

- **Primary key (inferred):** The combination of `account_tax_repartition_line_id` and `account_account_tag_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_tax_repartition_line_id` → `account_tax_repartition_line.id` (Inferred from Odoo naming convention).
    - `account_account_tag_id` → `account_account_tag.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only foreign keys.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.
- As a staging table, it reflects the raw state of the Odoo database; there are no audit timestamps or soft-delete flags present.