# sale_mass_cancel_orders

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based defaults (`nextval` on a `_seq` object).

## Functional process 
This table supports the mass cancellation of sales orders, likely tracking the execution of a bulk operation within the sales management module. It acts as an audit or log entity for batch processes where multiple orders are cancelled simultaneously.

## Description
One row represents a single execution event of a mass cancellation process. It serves as a raw landing record in the staging layer, capturing the metadata of who performed the bulk cancellation and when the record was created or modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.sale_mass_cancel_orders_id_seq`. |
| create_uid | INTEGER | true | User ID who initiated the mass cancellation | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified this record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely UTC; standard Odoo audit field. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely UTC; standard Odoo audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table contains audit fields (`create_uid`, `write_uid`) which are internal system identifiers; ensure these are joined against the appropriate user dimension table.
- Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- This table appears to be an audit/log of an action rather than a transactional record of the orders themselves; check for a related link table (e.g., `sale_mass_cancel_orders_rel`) if you need to identify which specific orders were cancelled.
- No PII is explicitly present, but user IDs should be handled according to internal data governance policies.