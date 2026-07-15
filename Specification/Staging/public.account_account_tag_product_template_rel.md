# account_account_tag_product_template_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `account_account_tag` and `product_template` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link accounting tags to product templates.

## Functional process 
This table supports the product-to-accounting classification process. It allows the business to assign specific accounting tags (used for reporting, tax mapping, or analytical accounting) to product templates, ensuring that when these products are sold or purchased, the associated accounting behavior is triggered.

## Description
One row in this table represents a single association between a product template and an accounting tag. It serves as a raw, junction-table copy from the source system, maintaining the many-to-many relationship required for the accounting module's configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | Links to the primary product definition. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag | Links to the specific accounting classification tag. |

## Keys

- **Primary key (inferred):** The combination of `(product_template_id, account_account_tag_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: This column references the master product definition table.
    - `account_account_tag_id` → `account_account_tag.id`: This column references the accounting tags configuration table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect no other columns (like timestamps or user IDs) as it is purely for relational mapping.
- There is no soft-delete flag; records are typically inserted or deleted directly by the application when the association is modified in the UI.
- Ensure joins to the parent tables handle the potential for missing records if referential integrity is not strictly enforced at the database level in the source system.