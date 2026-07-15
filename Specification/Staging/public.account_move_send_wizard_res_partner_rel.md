# account_move_send_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_partner_id` and `account_move_send_wizard_id` is characteristic of Odoo's relational mapping, where `res_partner` represents the core business partner entity and `account_move` refers to accounting journal entries.

## Functional process 
This table supports the "Account Move Send" wizard process, which handles the batch distribution of accounting documents (such as invoices or credit notes) to business partners. It acts as a join table to associate specific business partners with a particular execution instance of the document-sending wizard.

## Description
One row in this table represents a many-to-many relationship between an instance of an account move sending wizard and a business partner. It serves as a raw landing copy of the association table used by the Odoo application to track which partners are targeted by a specific document-sending operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_send_wizard_id | INTEGER | false | Foreign key to the wizard instance | Links to the primary key of the `account_move_send_wizard` table. |
| res_partner_id | INTEGER | false | Foreign key to the business partner | Links to the primary key of the `res_partner` table. |

## Keys

- **Primary key (inferred):** Composite key of (`account_move_send_wizard_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `account_move_send_wizard_id` → `account_move_send_wizard.id`: Evidence is the naming convention matching Odoo's ORM relational field patterns.
    - `res_partner_id` → `res_partner.id`: Evidence is the standard Odoo naming convention for partner references.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this staging table.
- As a staging table, it is assumed to be truncated and reloaded or managed by the Odoo ETL process; verify if historical wizard associations are preserved or purged after the wizard execution completes.
- No PII is directly contained in this table, though it links sensitive accounting document distribution events to specific partners.