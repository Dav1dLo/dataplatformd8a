# account_fiscal_position_account

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_fiscal_position_account`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL schema.

## Functional process 
This table supports the tax mapping and fiscal position process. It defines how specific general ledger accounts are remapped when a particular fiscal position (e.g., tax exemption, intra-community trade) is applied to a transaction, ensuring correct tax accounting based on the `position_id`.

## Description
One row represents a single account mapping rule within a fiscal position, defining a source account that should be replaced by a destination account under specific fiscal conditions. This is a raw landing table in the staging layer, capturing the configuration state of fiscal mappings as