# account_report_section_rel

## Source system
Unknown — insufficient evidence. The naming convention suggests a relational mapping table, likely from a custom internal reporting or dashboarding application, but there is no specific vendor signature (e.g., SAP, Salesforce) present in the schema or column names.

## Functional process 
This table supports a hierarchical or modular reporting structure, likely managing the relationship between parent report containers and their constituent sub-sections or child reports. It facilitates the assembly of complex reports by linking primary report entities to their sub-components.

## Description
One row represents a single association between a parent report and a child report or section. It serves as a raw landing copy of a many-to-many relationship mapping table, used to reconstruct report hierarchies within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| main_report_id | INTEGER | false | Identifier of the parent or primary report. | Foreign key reference to the parent report entity. |
| sub_report_id | INTEGER | false | Identifier of the child report or section. | Foreign key reference to the child report entity. |

## Keys

- **Primary key (inferred):** The composite of (`main_report_id`, `sub_report_id`) is the inferred primary key, as this is a standard junction table pattern.
- **Foreign keys (inferred):** 
    - `main_report_id` → `reports.id` (guess: links to the primary report definition).
    - `sub_report_id` → `reports.id` (guess: links to the child report definition).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect high cardinality and frequent joins against the parent report tables.
- There are no audit timestamps (e.g., `created_at`) provided; it is impossible to determine the temporal validity of these relationships from this table alone.
- The table contains no surrogate primary key; ensure queries handle the composite key correctly to avoid duplicate relationship records.