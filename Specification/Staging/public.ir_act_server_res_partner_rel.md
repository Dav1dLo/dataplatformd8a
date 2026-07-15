# ir_act_server_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_server_res_partner_rel` follows Odoo's standard pattern for many-to-many relationship tables, where `ir_act_server` refers to server-side actions and `res_partner` refers to the core business partner (customer/vendor) entity.

## Functional process 
This table supports the association of server-side actions with specific business partners. It is typically used in automation workflows where specific server actions (such as automated emails, scheduled tasks, or custom triggers) are linked to or filtered by a subset of partners.

## Description
One row in this table represents a single link between a server action and a business partner. It acts as a join table to resolve a many-to-many relationship between the `ir_act_server` and `res_partner` entities. As a staging table, it provides a raw, un-transformed view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_act_server_id | INTEGER | false | Foreign key to the server action | Links to the primary key of the server action definition. |
| res_partner_id | INTEGER | false | Foreign key to the business partner | Links to the primary key of the partner entity. |

## Keys

- **Primary key (inferred):** The composite key `(ir_act_server_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `ir_act_server_id → ir_act_server.id`: This column references the server action definition table.
    - `res_partner_id → res_partner.id`: This column references the core partner master data table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to track when these associations were created or modified.
- Ensure that joins to the parent tables (`ir_act_server` and `res_partner`) handle potential missing records if referential integrity is not strictly enforced in the source system.