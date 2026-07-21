# Fully Qualified Name: DWH.DimAccount

## Description
This dimension table represents the Chart of Accounts, providing a structured and categorized view of financial accounts used for reporting and transaction tracking. It standardizes account information from the source system to support consistent financial analysis.

## Grain
One row per unique account identifier.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| AccountKey | SK | integer | integer | System-generated surrogate key. | |
| AccountBK | BK | integer | integer | Direct mapping from public.account_account.id. | |
| AccountCode | SCD1 | varchar(255) | varchar(255) | Extracted from public.account_account.code_store using JSONB text extraction. | |
| AccountName | SCD1 | varchar(500) | varchar(500) | Extracted from public.account_account.name using JSONB text extraction. | |
| AccountType | SCD1 | varchar(100) | varchar(100) | Pass-through from public.account_account.account_type. | |
| IsDeprecated | SCD1 | boolean | boolean | Pass-through from public.account_account.deprecated. | |
| IsReconcilable | SCD1 | boolean | boolean | Pass-through from public.account_account.reconcile. | |
| IsNonTrade | SCD1 | boolean | boolean | Pass-through from public.account_account.non_trade. | |
| AccountDescription | SCD1 | text | text | Pass-through from public.account_account.note. | |

## Transformation Logic
The table is populated by selecting unique records from the staging table `public.account_account`. JSONB fields `name` and `code_store` are extracted to their text representations. The grain is maintained by ensuring a one-to-one mapping with the source primary key `id`.

## Lineage
- Reads from: [public.account_account](../Staging/public.account_account.md)

## Notes
- The `AccountCode` and `AccountName` are extracted from JSONB fields; if multiple languages exist in the source, the default or primary language string should be selected based on business requirements.
- This dimension is modeled as Type 1, assuming that changes to account attributes (like name or deprecation status) should be reflected globally across all historical reporting.