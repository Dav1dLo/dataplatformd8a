# pos_config_pos_payment_method_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `pos_config_pos_payment_method_rel`, which is the standard pattern for a many-to-many join table in the Odoo ORM (Object-Relational Mapping) layer.

## Functional process 
This table supports the Point of Sale (POS) configuration process by mapping which payment methods are available for use at specific POS terminals. It facilitates the relationship between a POS configuration (the terminal setup) and the payment methods (e.g., cash, card, digital wallet) enabled for that terminal.

## Description
One row in this table represents a single association between a specific POS configuration and an enabled payment method. It serves as a raw landing copy of the join table used to resolve the many-to-many relationship between POS terminals and payment options in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the terminal definition. |
| pos_payment_method_id | INTEGER | false | Foreign key to the payment method | Links to the available payment type. |

## Keys

- **Primary key (inferred):** The composite key `(pos_config_id, pos_payment_method_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the primary configuration record for the POS terminal.
    - `pos_payment_method_id` → `pos_payment_method.id`: This column references the definition of the payment method.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There are no timestamps or audit columns present in this table; incremental loading logic should rely on upstream source system logs or full-table refreshes.
- Ensure that joins to this table are filtered by both columns to avoid Cartesian products if the relationship is not strictly enforced by the source application.