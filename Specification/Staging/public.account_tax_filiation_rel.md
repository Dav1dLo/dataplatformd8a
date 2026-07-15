# account_tax_filiation_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between tax entities, but the naming convention does not align with common ERPs like SAP, Salesforce, or Dynamics.

## Functional process 
This table supports tax hierarchy or dependency management. It defines the parent-child relationships between tax records, likely used to calculate cascading taxes or aggregate tax reporting across a corporate structure.

## Description
One row in this table represents a single directed link between a parent tax entity and a child tax entity. As a staging table, it serves as a raw, normalized representation of the tax hierarchy structure extracted from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| parent_tax | INTEGER | false | Identifier of the parent tax entity | Foreign key to the primary tax table. |
| child_tax | INTEGER | false | Identifier of the child tax entity | Foreign key to the primary tax table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key on (`parent_tax`, `child_tax`).
- **Foreign keys (inferred):** 
    - `parent_tax` → `tax_entities.id` (guess: represents the superior tax node).
    - `child_tax` → `tax_entities.id` (guess: represents the subordinate tax node).
- **Natural keys (inferred):** The combination of (`parent_tax`, `child_tax`) acts as the business key for the relationship.

## Caveats for downstream consumers

- No PII or sensitive financial data is present in this mapping table.
- This table represents a recursive relationship; ensure queries handle potential cycles if the source data is not strictly hierarchical.
- There are no audit timestamps (e.g., `created_at`) provided; assume this is a snapshot of the current state or a full-load extract.