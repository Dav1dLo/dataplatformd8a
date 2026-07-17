# Fully Qualified Name: DataWarehouse.FactSalesOrderLine

## Description
This fact table captures the granular details of sales order lines, providing a comprehensive view of product sales, discounting, and fulfillment status. It enables analysis of sales performance at the line-item level, supporting business questions regarding product-specific sales volume, discount effectiveness, and fulfillment efficiency.

## Grain
One row per sales order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DataWarehouse | SalesOrderLineSK | PK | bigint | 8 bytes | Surrogate key generated for the fact table. | |
| DataWarehouse | OrderDateSK | FK | integer | 4 bytes | Derived from `public.sale_order.date_order` to link to a Date dimension. | |
| DataWarehouse | ProductSK | FK | integer | 4 bytes | References `public.product_product.id`. | |
| DataWarehouse | SalesOrderLineID | DD | integer | 4 bytes | Pass-through from `public.sale_order_line.id`. | |
| DataWarehouse | SalesOrderNumber | DD | varchar | 255 | Pass-through from `public.sale_order.name`. | |
| DataWarehouse | QuantityOrdered | ADD | numeric(38, 6) | Source precision unknown | Pass-through from `public.sale_order_line.product_uom_qty`. | sum |
| DataWarehouse | QuantityDelivered | ADD | numeric(38, 6) | Source precision unknown | Pass-through from `public.sale_order_line.qty_delivered`. | sum |
| DataWarehouse | UnitPrice | NON | numeric(38, 6) | Source precision unknown | Pass-through from `public.sale_order_line.price_unit`. | |
| DataWarehouse | DiscountPercentage | NON | numeric(38, 6) | Source precision unknown | Pass-through from `public.sale_order_line.discount`. | average |
| DataWarehouse | LineSubtotal | ADD | numeric(38, 6) | Source precision unknown | Pass-through from `public.sale_order_line.price_subtotal`. | sum |
| DataWarehouse | FulfillmentStatus | DD | varchar | 50 | Derived from `public.sale_order_line.qty_delivered` vs `public.sale_order_line.product_uom_qty`. | |

## Transformation Logic
The table is populated by joining `public.sale_order_line` with `public.sale_order` on `order_id` = `id` to retrieve order-level context (like `date_order`). `public.product_product` is joined on `product_id` = `id` to resolve product attributes. Surrogate keys are generated for the fact table, and dimensions are referenced via their respective surrogate keys. Fulfillment status is calculated as a degenerate dimension based on the comparison of ordered vs. delivered quantities.

## Lineage
- Reads from: [public.sale_order](../Staging/public.sale_order.md)
- Reads from: [public.sale_order_line](../Staging/public.sale_order_line.md)
- Reads from: [public.product_product](../Staging/public.product_product.md)

## Notes
- `QuantityOrdered` and `QuantityDelivered` are treated as additive measures.
- `UnitPrice` and `DiscountPercentage` are treated as non-additive measures, as they represent rates/unit values.
- The `FulfillmentStatus` is a derived attribute based on the relationship between ordered and delivered quantities.
- Precision for numeric fields is set to `numeric(38, 6)` as a safe default for financial and quantity data where source precision is not explicitly defined in the Odoo schema.