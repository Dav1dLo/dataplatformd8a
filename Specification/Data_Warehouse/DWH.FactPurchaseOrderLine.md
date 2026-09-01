# Fully Qualified Name: DWH.FactPurchaseOrderLine

## Description
This fact table captures the granular details of purchase order lines, providing a comprehensive view of procurement activities. It enables analysis of spend, quantity variances between ordered and received goods, and procurement lead times.

## Grain
One row per purchase order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | PurchaseOrderLineKey | PK | bigint | 8 bytes | Surrogate key generated for each line item. | |
| DWH | ProductKey | FK | bigint | 8 bytes | Lookup `DWH.DimProduct.ProductKey` using `public.purchase_order_line.product_id`. | |
| DWH | VendorKey | FK | bigint | 8 bytes | Lookup `DWH.DimVendor.VendorKey` using `public.purchase_order.partner_id`. | |
| DWH | OrderDateKey | FK | integer | 8 bytes | Lookup `DWH.DimDate.DateKey` using `public.purchase_order.date_order`. | |
| DWH | PurchaseOrderLineBK | DD | integer | 4 bytes | Source `public.purchase_order_line.id`. | |
| DWH | OrderedQuantity | ADD | numeric(18,6) | 18,6 | Source `public.purchase_order_line.product_qty`. | SUM |
| DWH | ReceivedQuantity | ADD | numeric(18,6) | 18,6 | Source `public.purchase_order_line.qty_received`. | SUM |
| DWH | UnitPrice | NON | numeric(18,6) | 18,6 | Source `public.purchase_order_line.price_unit`. | AVERAGE |
| DWH | LineTotalAmount | ADD | numeric(18,6) | 18,6 | Source `public.purchase_order_line.price_subtotal`. | SUM |
| DWH | LeadTimeDays | SEMI | integer | 4 bytes | Calculated as `public.purchase_order_line.date_planned` - `public.purchase_order.date_order`. | AVERAGE |

## Transformation Logic
The table is populated by joining `public.purchase_order_line` with `public.purchase_order` on `purchase_order_line.order_id = purchase_order.id`. Surrogate keys are resolved by joining to the respective dimension tables:
- `ProductKey` via `DWH.DimProduct` on `product_id` = `ProductBK`.
- `VendorKey` via `DWH.DimVendor` on `partner_id` = `VendorBK`.
- `OrderDateKey` via `DWH.DimDate` on `date_order` = `FullDate`.

## Lineage
- Reads from: [DWH.DimProduct](../Dimension/DWH.DimProduct.md)
- Reads from: [DWH.DimVendor](../Dimension/DWH.DimVendor.md)
- Reads from: [DWH.DimDate](../Dimension/DWH.DimDate.md)
- Reads from: [public.purchase_order_line](../Staging/public.purchase_order_line.md)
- Reads from: [public.purchase_order](../Staging/public.purchase_order.md)

## Notes
- `LineTotalAmount` represents the net amount for the line item as provided by the source system.
- `LeadTimeDays` is calculated at the line level; it may be null if the planned date is not set.
- `UnitPrice` is treated as a non-additive measure (average) as summing unit prices across multiple products is not meaningful.