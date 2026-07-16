# merge_opportunity_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between merge events and opportunities, which is common in custom-built CRM middleware or internal sales-tracking databases. It lacks standard vendor-specific prefixes (e.g., `sf_`, `crm_`) that would definitively link it to a major SaaS platform.

## Functional process 
This table supports a sales pipeline management or data-cleansing process, specifically tracking the association between "merge" events (likely deduplication or consolidation of records) and the specific opportunities involved in those operations. It serves as a junction table to maintain a many-to-many or one-to-many relationship between merge actions and opportunity records.

## Description
One row in this table represents a single association between a specific merge event and an opportunity. It is a raw landed staging table intended to capture the link between these two entities before any downstream transformation or deduplication logic is applied.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| merge_id | INTEGER | false | Surrogate key identifying the merge event | Likely a foreign key to a parent merge_events table. |
| opportunity_id | INTEGER | false | Surrogate key identifying the opportunity | Likely a foreign key to an opportunities table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key on (`merge_id`, `opportunity_id`).
- **Foreign keys (inferred):** 
    - `merge_id` → `merge_events.id` (guess: standard naming convention for parent-child relationships).
    - `opportunity_id` → `opportunities.id` (guess: standard naming convention for linking to an opportunity entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction/link table; expect high cardinality and frequent joins.
- There is no audit timestamp or soft-delete flag present; assume this is a snapshot of current relationships as provided by the source.
- Ensure that downstream joins handle potential duplicates if the source system allows multiple entries for the same merge-opportunity pair.