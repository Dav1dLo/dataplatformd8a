# product_attr_exclusion_value_ids_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `product_template_attribute_exclusion_id` and the `_rel` suffix are characteristic of Odoo's ORM, which generates join tables for many-to-many relationships between product attribute exclusions and their associated attribute values.

## Functional process 
This table supports the product configuration and variant management process. It defines the specific attribute values that are excluded when a particular product template attribute exclusion rule is triggered, ensuring that invalid combinations of product variants cannot be selected by users or customers.

## Description
One row represents a single association between a product template attribute exclusion rule and a specific attribute value that is restricted by that rule. This is a raw landing of a many-to-many relationship table, serving as a bridge to enforce product configuration constraints.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_attribute_exclusion_id | INTEGER | false | Foreign key to the exclusion rule definition. | Links to the parent exclusion record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the specific attribute value being excluded. | Represents the restricted value. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both columns `(product_template_attribute_exclusion_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `product_template_attribute_exclusion_id` → `product_template_attribute_exclusion.id`: This column references the master exclusion rule record.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the specific attribute value record.
- **Natural keys (inferred):** The combination of `product_template_attribute_exclusion_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the history or creation date of these relationships from this table alone.
- Ensure that joins to the parent tables handle the `INTEGER` types correctly to avoid implicit casting issues if the target tables use different integer widths.
- As a staging table, it is assumed to be a direct reflection of the source database; check for orphaned records if referential integrity is not strictly enforced in the source system.