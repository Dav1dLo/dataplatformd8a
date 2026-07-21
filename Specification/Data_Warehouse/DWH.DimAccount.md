# Fully Qualified Name: DWH.DimAccount

## Description
This dimension table provides a comprehensive view of financial accounts, including their base configuration and associated analytical tags. It is designed to support financial reporting and account categorization.

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
| AccountCode | SCD1 | varchar(255) | varchar(255) | Extracted from public.account_account.code_store using ->> operator. | |
| AccountName | SCD1 | varchar(255) | varchar(255) | Extracted from public.account_account.name using ->> operator. | |
| AccountType | SCD1 | varchar(255) | varchar(255) | Pass-through from public.account_account.account_type. | |
| IsDeprecated | SCD1 | boolean | boolean | Pass-through from public.account_account.deprecated. | |
| IsReconcilable | SCD1 | boolean | boolean | Pass-through from public.account_account.reconcile. | |
| IsNonTrade | SCD1 | boolean | boolean | Pass-through from public.account_account.non_trade. | |
| AccountTags | SCD1 | text | text | Aggregated list of tag names (from public.account_account_tag.name) associated with the account via public.account_account_account_tag. | |

## Transformation Logic
The table is populated by selecting all records from `public.account_account`. Account tags are resolved by joining `public.account_account` to `public.account_account_account_tag` on `id` = `account_account_id`, and then to `public.account_account_tag` on `account_account_tag_id` = `id`. The tags are aggregated into a single text field per account.

## Lineage
- Reads from: [public.account_account](../Staging/public.account_account.md)
- Reads from: [public.account_account_tag](../Staging/public.account_account_tag.md)
- Reads from: [public.account_account_account_tag](../Staging/public.account_account_account_tag.md)

## Notes
- The `AccountTags` column is a comma-separated list of tags associated with the account.
- JSONB fields from the source are extracted to text using the `->>` operator, assuming the default language or a standard extraction pattern.
- This is a Type 1 dimension; changes to account attributes will overwrite existing records.