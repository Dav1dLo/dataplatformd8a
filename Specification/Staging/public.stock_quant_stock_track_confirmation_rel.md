# stock_quant_stock_track_confirmation_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_quant` and `stock_track_confirmation` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link inventory quantities (quants) with tracking confirmation records.

## Functional process 
This table supports the inventory management and traceability process. It facilitates the many-to-many relationship between individual stock quant records (representing specific inventory items in a location) and stock tracking confirmations (representing validation or movement tracking events), ensuring that inventory movements can be audited against specific confirmation records.

## Description
One row in this table represents a single association between a stock quantity record and a stock tracking confirmation event. It serves as a raw landing join table in the staging layer, maintaining the referential link between inventory state and tracking validation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_track_confirmation_id | INTEGER | false | Foreign key to the stock tracking confirmation record. | Links to the parent confirmation event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record. | Links to the specific inventory quantity record. |

## Keys

- **Primary key (inferred):** The combination of `(stock_track_confirmation_id, stock_quant_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_track_confirmation_id` → `stock_track_confirmation.id` (Inferred from Odoo naming conventions).
    - `stock_quant_id` → `stock_quant.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect high cardinality and frequent joins to the parent tables.
- There is no surrogate primary key; ensure joins use both columns to maintain uniqueness.
- As a raw staging table, it contains no audit timestamps or soft-delete flags; assume all records are active as of the time of ingestion.