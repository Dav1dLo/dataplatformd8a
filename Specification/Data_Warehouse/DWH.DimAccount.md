# Fully Qualified Name: DWH.DimAccount

## Description
Represents the chart of accounts used for financial reporting and categorization of accounting entries. This dimension provides descriptive attributes for accounts, including their classification, status, and identification codes.

## Grain
One row per account.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| AccountKey | SK | integer | integer | System-generated surrogate key. | |
| AccountBK | BK | integer | integer | Pass-through from public.account_account.id. | |
| AccountCode | SCD1 | varchar(255) | varchar(255) | Extracted from public.account_account.code_store using JSONB text operator. | |
| AccountName | SCD1 | varchar(500) | varchar(500) | Extracted from public.account_account.name using JSONB text operator. | |
| AccountType | SCD1 | varchar(255) | varchar(255) | Pass-through from public.account_account.account_type. | |
| IsDeprecated | SCD1 | boolean | boolean | Pass-through from public.account_account.deprecated. | |
| SupportsReconciliation | SCD1 | boolean | boolean | Pass-through from public.account_account.reconcile. | |
| IsNonTrade | SCD1 | boolean | boolean | Pass-through from public.account_account.non_trade. | |
| AccountDescription | SCD1 | text | text | Pass-through from public.account_account.note. | |

## Transformation Logic
The dimension is loaded from `public.account_account`. The `AccountKey` is generated as a surrogate key. Business attributes are mapped directly from the source, with JSONB fields (`name`, `code_store`) extracted to text format. The grain is defined by the unique `id` of the source account.

## Lineage
- Reads from: [public.account_account](../Staging/public.account_account.md)

## Notes
- The `AccountCode` and `AccountName` are extracted from JSONB fields; if the source JSONB contains multiple languages, the default language value is extracted.
- `AccountBK` corresponds to the Odoo internal ID, which serves as the unique identifier for accounts in the source system.