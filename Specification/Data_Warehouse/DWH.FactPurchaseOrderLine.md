# Fully Qualified Name: DWH.FactPurchaseOrderLine

## Description
This fact table captures the granular details of purchase order lines, representing the procurement of goods and services from vendors. It enables analysis of ordered versus received quantities, spend, and vendor performance across different companies.

## Grain
One row per purchase order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | PurchaseOrderLineSK | SK | bigint | bigint | Surrogate key generated for each line item. | |
| DWH | ProductKey | FK | integer | integer | Lookup on DWH.DimProduct.ProductBK using public.purchase_order_line.product_id. | |
| DWH | VendorKey | FK | integer | 4 bytes | Lookup on DWH.DimVendor.VendorBK using public.purchase_order.partner_id. | |
| DWH | CompanyKey | FK | integer | integer | Lookup on DWH.DimCompany.CompanyBK using public.purchase_order.company_id. | |
| DWH | OrderDateKey | FK | integer | integer | Date key derived from public.purchase_order.date_order. | |
| DWH | PurchaseOrderLineBK | DD | integer | integer | Pass-through from public.purchase_order_line.id. | |
| DWH | QuantityOrdered | ADD | numeric(38,6) | numeric(38,6) | Pass-through from public.purchase_order_line.product_qty. | SUM |
| DWH | QuantityReceived | ADD | numeric(38,6) | numeric(38,6) | Pass-through from public.purchase_order_line.qty_received. | SUM |
| DWH | QuantityInvoiced | ADD | numeric(38,6) | numeric(38,6) | Pass-through from public.purchase_order_line.qty_invoiced. | SUM |
| DWH | PriceUnit | NON | numeric(38,6) | numeric(38,6) | Pass-through from public.purchase_order_line.price_unit. | |
| DWH | TotalAmount | ADD | numeric(38,6) | numeric(38,6) | Calculated as public.purchase_order_line.price_subtotal. | SUM |

## Transformation Logic
The table is populated by joining `public.purchase_order_line` with `public.purchase_order` on `purchase_id`. Surrogate keys are resolved by looking up the corresponding business keys in the dimension tables:
- `ProductKey` from `DWH.DimProduct` via `product_id`.
- `VendorKey` from `DWH.DimVendor` via `partner_id` (from `purchase_order`).
- `CompanyKey` from `DWH.DimCompany` via `company_id` (from `purchase_order`).
- `OrderDateKey` is derived from the `date_order` timestamp in `public.purchase_order`.

## Lineage
- Reads from: [DWH.DimProduct](../DataWarehouse/DWH.DimProduct.md)
- Reads from: [DWH.DimVendor](../DataWarehouse/DWH.DimVendor.md)
- Reads from: [DWH.DimCompany](../DataWarehouse/DWH.DimCompany.md)
- Reads from: [public.purchase_order_line](../Staging/public.purchase_order_line.md)
- Reads from: [public.purchase_order](../Staging/public.purchase_order.md)

## Notes
- `PriceUnit` is marked as `NON` (non-additive) as it represents a rate; it should be used in weighted average calculations rather than simple summation.
- `QuantityOrdered`, `QuantityReceived`, and `QuantityInvoiced` are additive measures.
- Pending receipt quantity can be calculated as `QuantityOrdered - QuantityReceived`.
- Pending invoice quantity can be calculated as `QuantityOrdered - QuantityInvoiced`.