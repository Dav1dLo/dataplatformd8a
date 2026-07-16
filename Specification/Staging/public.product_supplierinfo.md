# product_supplierinfo

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `product_tmpl_id`, `create_uid`, `write_uid`, and the use of sequence-based primary keys (`nextval` on `product_supplierinfo_id_seq`).

## Functional process 
This table supports the procurement and supply chain management process, specifically tracking vendor-specific product information. It defines the relationship between products and their suppliers, including lead times, pricing tiers, and validity periods for purchasing agreements.

## Description
One row in this table represents a specific supplier's price list or lead-time configuration for a product or product template. It serves as a raw landed copy of the Odoo `product.supplierinfo` model, capturing the commercial terms offered by a partner for a given item.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| partner_id | INTEGER | false | Foreign key to the supplier | References the partner/vendor entity. |
| sequence | INTEGER | true | Sorting priority | Used to determine the order of supplier selection. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| currency_id | INTEGER | false | Currency reference | References the currency used for the price. |
| product_id | INTEGER | true | Specific product variant ID | Links to a specific product variant. |
| product_tmpl_id | INTEGER | true | Product template ID | Links to the generic product definition. |
| delay | INTEGER | false | Lead time in days | Expected delivery time from the supplier. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| product_name | VARCHAR | true | Supplier's product name | Name used by the vendor for this item. |
| product_code | VARCHAR | true | Supplier's product code | SKU or part number used by the vendor. |
| date_start | DATE | true | Validity start date | The date from which this price/term is active. |
| date_end | DATE | true | Validity end date | The date after which this price/term expires. |
| min_qty | NUMERIC | false | Minimum order quantity | The threshold quantity for this price to apply. |
| price | NUMERIC | false | Unit price | The cost per unit offered by the supplier. |
| discount | NUMERIC | true | Discount percentage | Applied discount on the unit price. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo partner reference).
    - `product_id` → `product_product.id` (Reference to specific variant).
    - `product_tmpl_id` → `product_template.id` (Reference to generic product).
    - `currency_id` → `res_currency.id` (Reference to currency definition).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically manages these via internal logic rather than a unique business key constraint.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the current state of the Odoo database.
- **Data Integrity:** `product_id` and `product_tmpl_id` are often mutually exclusive depending on whether the supplier info is defined at the variant or template level.
- **Precision:** `price`, `min_qty`, and `discount` are `NUMERIC` types; ensure downstream systems handle decimal precision correctly to avoid rounding errors.