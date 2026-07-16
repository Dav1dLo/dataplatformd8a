# product_optional_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between products, but the lack of prefixing or specific naming conventions (like `sap_`, `sf_`, or `stripe_`) makes it impossible to attribute this to a specific operational system without further context.

## Functional process 
This table supports product catalog management, specifically defining optional or cross-sell relationships between items. It likely facilitates "frequently bought together" or "recommended add-on" features within an e-commerce or inventory management system.

## Description
One row in this table represents a single directed relationship where one product is identified as an optional or related item to another. As a staging table, it serves as a raw, landed copy of a junction table used to resolve many-to-many associations between products.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| src_id | INTEGER | false | Source product identifier | Represents the primary or "parent" product in the relationship. |
| dest_id | INTEGER | false | Destination product identifier | Represents the related or "optional" product. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table lacks a surrogate key; it is likely a composite key of `(src_id, dest_id)`.
- **Foreign keys (inferred):** 
    - `src_id` → `product.id` (guess): Likely references the primary product table.
    - `dest_id` → `product.id` (guess): Likely references the related product table.
- **Natural keys (inferred):** 
    - `(src_id, dest_id)`: The combination of source and destination IDs is expected to be unique for this relationship type.

## Caveats for downstream consumers

- This table appears to be a link table; ensure joins are handled carefully to avoid Cartesian products if joining multiple relationship types.
- There is no metadata indicating if these relationships are symmetric (i.e., if A relates to B, does B relate to A?); assume directed unless business logic dictates otherwise.
- No audit timestamps or soft-delete flags are present; assume this table represents the current state of relationships as captured during the last ingestion.