# Fully Qualified Name: DWH.DimDate

## Description
A standard calendar dimension table providing attributes for time-based analysis of procurement activities, such as purchase order creation and delivery dates.

## Grain
One row per calendar day.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| DateKey | SK | integer | 8 bytes | System-generated surrogate key (YYYYMMDD). | |
| FullDate | SCD1 | date | 4 bytes | The actual calendar date. | |
| DayOfWeek | SCD1 | varchar(10) | 10 | Name of the day of the week (e.g., Monday). | |
| DayOfMonth | SCD1 | integer | 4 bytes | Day number within the month (1-31). | |
| MonthNumber | SCD1 | integer | 4 bytes | Month number within the year (1-12). | |
| MonthName | SCD1 | varchar(10) | 10 | Name of the month (e.g., January). | |
| Quarter | SCD1 | integer | 4 bytes | Calendar quarter (1-4). | |
| Year | SCD1 | integer | 4 bytes | Calendar year (e.g., 2023). | |
| IsWeekend | SCD1 | boolean | 1 byte | Flag indicating if the date falls on a weekend. | |

## Transformation Logic
The table is populated by generating a continuous range of dates covering the historical and future requirements of the procurement business process. Attributes are derived from the `FullDate` value using standard date/time functions.

## Lineage
- Reads from: None (System-generated dimension)

## Notes
- The `DateKey` is formatted as an integer `YYYYMMDD` to allow for efficient joins and range filtering.
- This dimension is intended to be used as a reference for all date-based filtering in the `DWH.FactPurchaseOrderLine` fact table.