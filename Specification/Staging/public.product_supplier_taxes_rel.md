# product_supplier_taxes_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a relational mapping between products and tax configurations, but lacks specific vendor-identifying prefixes or naming conventions that would point to a specific ERP or CRM system.

## Functional process 
This table supports the tax compliance and product catalog management process. It acts as a bridge table to associate specific tax rules or jurisdictions with individual products, likely used to determine the correct tax rate or taxability status during the order-to-cash or procurement lifecycle.

## Description
One row in this table represents a single association between a product and a specific tax entity. It is a raw landed copy of a many-to-many relationship table, serving as the base for building downstream dimension attributes or tax calculation logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Surrogate key of the product | References the primary product catalog. |
| tax_id | INTEGER | false | Surrogate key of the tax rule | References the tax configuration or jurisdiction table. |

## Keys

- **Primary key (inferred):** The combination of (`prod_id`, `tax_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `prod_id` → `products.id` (guess: standard naming convention for product references).
    - `tax_id` → `taxes.id` (guess: standard naming convention for tax rule references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between products and taxes.
- There are no audit timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to parent tables handle potential orphan records if referential integrity is not strictly enforced in the source system.