# product_taxes_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relational mapping between products and tax configurations, which is common in custom-built e-commerce or ERP modules. There are no specific vendor-prefixed columns or naming conventions to definitively link this to a major platform like SAP, Salesforce, or Stripe.

## Functional process 
This table supports the tax calculation and compliance process by mapping products to their applicable tax rules or jurisdictions. It acts as a bridge table to resolve a many-to-many relationship between product definitions and tax definitions, ensuring that the correct tax logic is applied during the order-to-cash or billing cycle.

## Description
One row in this table represents a single association between a specific product and a specific tax rule. It serves as a raw landing copy of a junction table, facilitating the normalization of tax-to-product assignments within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Surrogate or natural key of the product | Foreign key to the product master table. |
| tax_id | INTEGER | false | Surrogate or natural key of the tax rule | Foreign key to the tax configuration table. |

## Keys

- **Primary key (inferred):** (`prod_id`, `tax_id`) — The combination of both columns is required to uniquely identify the relationship.
- **Foreign keys (inferred):** 
    - `prod_id` → `products.id` (guess: standard naming convention for product references).
    - `tax_id` → `taxes.id` (guess: standard naming convention for tax rule references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure relationship mapping.
- There is no soft-delete flag; assume that the absence of a record implies the removal of the tax association.
- As a junction table, ensure that joins to this table are handled carefully to avoid fan-out effects if joining to multiple one-to-many tables simultaneously.