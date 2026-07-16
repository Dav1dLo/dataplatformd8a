# meeting_category_rel

## Source system
Unknown — insufficient evidence. The table name suggests a junction table between events and categories, but the naming convention does not map clearly to common ERP or CRM systems like Salesforce, SAP, or Dynamics.

## Functional process 
This table supports a many-to-many relationship mapping between events and their associated categories. It is likely used to facilitate filtering or grouping of events within a scheduling or event management module.

## Description
One row represents a single association between a specific event and a specific category. This is a raw landing of a junction table, serving as the bridge entity to resolve many-to-many relationships between events and categories in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| event_id | INTEGER | false | Foreign key referencing the event entity | None |
| type_id | INTEGER | false | Foreign key referencing the category type entity | None |

## Keys

- **Primary key (inferred):** Composite key of (`event_id`, `type_id`).
- **Foreign keys (inferred):** 
    - `event_id` → `events.id` (Guess: standard naming convention for event-related tables).
    - `type_id` → `category_types.id` (Guess: standard naming convention for category-related tables).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; ensure joins are handled carefully to avoid fan-out issues if joining to multiple dimension tables simultaneously.
- No audit timestamps or soft-delete flags are present; assume this table reflects the current state of associations as captured during the last ingestion.
- The table contains no surrogate primary key; use the composite of both columns for unique identification.