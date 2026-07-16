# printer_category_rel

## Source system
Unknown — insufficient evidence. The naming convention `_rel` suggests a junction table used to resolve a many-to-many relationship, but the lack of system-specific prefixes or metadata makes it impossible to attribute to a specific operational system like SAP or Salesforce.

## Functional process 
This table supports a many-to-many mapping process between printers and their associated categories. It is likely used to facilitate product catalog management or inventory classification, allowing a single printer to be associated with multiple categories (e.g., "Laser", "Office", "Network-Ready").

## Description
One row in this table represents a single association between a specific printer and a specific category. As a staging table, it serves as a raw, normalized link entity intended to be joined with master data tables for printers and categories in downstream modeling layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| printer_id | INTEGER | false | Surrogate key referencing the printer entity | Foreign key to the printer master table. |
| category_id | INTEGER | false | Surrogate key referencing the category entity | Foreign key to the category master table. |

## Keys

- **Primary key (inferred):** (`printer_id`, `category_id`)
- **Foreign keys (inferred):** 
    - `printer_id` → `printer.id`: Links the association to the specific printer record.
    - `category_id` → `category.id`: Links the association to the specific category record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to join this with at least two other tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns; it is unclear if this table tracks historical associations or only the current state.
- The table does not contain soft-delete flags; assume that the absence of a record implies the absence of an association.