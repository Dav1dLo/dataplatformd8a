# product_pricelist_item

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `product_tmpl_id`, `categ_id`, `create_uid`, `write_uid`) and the specific sequence-based primary key pattern are characteristic of Odoo's PostgreSQL-based object-relational mapping.

## Functional process 
This table supports the "Price Management" or "Sales Pricing" business process. It defines the granular rules for how prices are calculated for specific products, categories, or global pricelists, including logic for discounts, surcharges, and quantity-based price breaks.

## Description
One row in this table represents a single pricing rule or condition applied to a product or category within a specific pricelist. It acts as a raw landed copy of the Odoo `product.pricelist.item` model, capturing the configuration for dynamic price computation, such as fixed prices, percentage discounts, or margin-based pricing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| pricelist_id | INTEGER | false | Foreign key to the parent pricelist | Links to `product.pricelist`. |
| company_id | INTEGER | true | Multi-company scope | Null if global. |
| currency_id | INTEGER | true | Currency identifier | Links to `res.currency`. |
| categ_id | INTEGER | true | Product category scope | Used if rule applies to a category. |
| product_tmpl_id | INTEGER | true | Product template scope | Used if rule applies to a product template. |
| product_id | INTEGER | true | Specific product variant scope | Used if rule applies to a specific variant