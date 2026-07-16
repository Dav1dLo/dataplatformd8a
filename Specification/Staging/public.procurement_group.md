# procurement_group

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of a sequence-based primary key (`procurement_group_id_seq`).

## Functional process 
This table supports the procurement and supply chain management process, specifically tracking the grouping of replenishment or fulfillment requests. It links procurement activities to specific business documents such as Point of Sale orders (`pos_order_id`) or sales orders (`sale_id`), facilitating the consolidation of stock moves.

## Description
One row in this table represents a single procurement group, which acts as a container for related stock movements or supply requirements. This is a raw landed copy from the source system, serving as the staging entity for downstream inventory and order fulfillment reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `procurement_group_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the partner/customer | Likely references a `res_partner` table. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Human-readable identifier or code | Often used as a reference number for the group. |
| move_type | VARCHAR | true | Classification of the procurement group | Defines the nature of the grouping logic. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| pos_order_id | INTEGER | true | Reference to the POS order | Links to the Point of Sale module. |
| sale_id | INTEGER | true | Reference to the sales order | Links to the Sales module. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner association).
    - `pos_order_id` → `pos_order.id` (Guess: links to POS module).
    - `sale_id` → `sale_order.id` (Guess: links to Sales module).
- **Natural keys (inferred):** 
    - `name` (Often acts as a unique document reference in Odoo).

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC.
- **Data Integrity:** `partner_id`, `pos_order_id`, and `sale_id` are nullable, suggesting that a procurement group might exist independently of a specific sales document or partner.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **PII:** No direct PII is present, though `partner_id` links to tables that likely contain sensitive customer information.