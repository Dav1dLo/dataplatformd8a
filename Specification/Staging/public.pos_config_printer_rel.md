# pos_config_printer_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (join tables) between two entities, in this case, point-of-sale configurations and printer devices.

## Functional process 
This table supports the Point of Sale (POS) hardware configuration process. It maps specific receipt or order printers to POS configurations, ensuring that when a transaction is processed at a specific terminal, the system knows which physical or network printer to route the output to.

## Description
One row in this table represents a single association between a POS configuration and a printer. It is a raw landing copy of a join table, serving as the bridge to resolve the many-to-many relationship between POS settings and hardware peripherals in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary configuration entity. |
| printer_id | INTEGER | false | Foreign key to the printer definition | Links to the hardware printer entity. |

## Keys

- **Primary key (inferred):** The combination of `(config_id, printer_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `config_id` → `pos_config.id` (Inferred from Odoo naming conventions for POS modules).
    - `printer_id` → `pos_printer.id` (Inferred from Odoo naming conventions for POS modules).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on this table for change tracking.
- Ensure inner joins are used when resolving these IDs to avoid orphaned records if the source system has referential integrity gaps.