# Fully Qualified Name: DWH.FactAnalyticEntry

## Description
This fact table captures granular analytic accounting entries, linking financial movements to specific accounts, partners, products, and analytic dimensions. It serves as the primary source for P&L reporting, cost analysis, and project-based financial tracking.

## Grain
One row per analytic line (`account_analytic_line`), representing a transaction-level financial event.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | AnalyticEntrySK | SK | bigint | 8 | System-generated surrogate key. | |
| DWH | AccountKey | FK | integer | integer | Lookup on DWH.DimAccount.AccountBK using public.account_analytic_line.account_id. | |
| DWH | PartnerKey | FK | bigint | 8 | Lookup on DWH.DimPartner.PartnerBK using public.account_analytic_line.partner_id. | |
| DWH | ProductKey | FK | integer | integer | Lookup on DWH.DimProduct.ProductBK using public.account_analytic_line.product_id. | |
| DWH | Date | DD | date | date | Pass-through from public.account_analytic_line.date. | |
| DWH | Amount | ADD | numeric(38,6) | numeric(38,6) | Pass-through from public.account_analytic_line.amount. | SUM |
| DWH | UnitAmount | ADD | numeric(38,6) | numeric(38,6) | Pass-through from public.account_analytic_line.unit_amount. | SUM |
| DWH | AnalyticEntryBK | DD | integer | integer | Pass-through from public.account_analytic_line.id. | |

## Transformation Logic
The table is populated by joining `public.account_analytic_line` with the corresponding dimension tables to resolve surrogate keys. 
- `AccountKey` is resolved by matching `public.account_analytic_line.account_id` to `DWH.DimAccount.AccountBK`.
- `PartnerKey` is resolved by matching `public.account_analytic_line.partner_id` to `DWH.DimPartner.PartnerBK`.
- `ProductKey` is resolved by matching `public.account_analytic_line.product_id` to `DWH.DimProduct.ProductBK`.
- Measures are sourced directly from `public.account_analytic_line`.

## Lineage
- Reads from: [DWH.DimAccount](../DataWarehouse/DWH.DimAccount.md)
- Reads from: [DWH.DimPartner](../DataWarehouse/DWH.DimPartner.md)
- Reads from: [DWH.DimProduct](../DataWarehouse/DWH.DimProduct.md)
- Reads from: [public.account_analytic_line](../Staging/public.account_analytic_line.md)
- Reads from: [public.account_move_line](../Staging/public.account_move_line.md)

## Notes
- `Amount` represents the total value of the analytic entry, while `UnitAmount` typically represents quantity (e.g., hours, units).
- `public.account_move_line` is referenced in the lineage as it is the source for the underlying financial movements that often trigger the creation of analytic lines, though the grain here is specifically the analytic line.
- Numeric precision `(38,6)` is used to accommodate standard financial and quantity precision requirements.