# stock_scrap_stock_scrap_reason_tag_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `<table>_<related_table>_rel` is a standard pattern used by Odoo's ORM to manage many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the inventory management and quality control process, specifically the categorization of scrapped stock. It links individual stock scrap records to one or more descriptive reason tags, allowing for granular reporting on why inventory was written off (e.g., "damaged", "expired", "obsolete").

## Description
One row in this table represents a single association between a specific stock scrap event and a reason tag. It serves as a junction table in the staging layer, maintaining the many-to-many relationship between the `stock_scrap` entity and the `stock_scrap_reason_tag` entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_scrap_id | INTEGER | false | Foreign key to the stock scrap record | Represents the specific scrap event. |
| stock_scrap_reason_tag_id | INTEGER | false | Foreign key to the scrap reason tag | Represents the classification tag assigned to the scrap. |

## Keys

- **Primary key (inferred):** The composite key `(stock_scrap_id, stock_scrap_reason_tag_id)`.
- **Foreign keys (inferred):** 
    - `stock_scrap_id` → `stock_scrap.id`: Links to the parent scrap event record.
    - `stock_scrap_reason_tag_id` → `stock_scrap_reason_tag.id`: Links to the definition of the scrap reason.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should perform `INNER JOIN` operations with the parent tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure that downstream models handle the potential for multiple rows per `stock_scrap_id` if a single scrap event is tagged with multiple reasons.