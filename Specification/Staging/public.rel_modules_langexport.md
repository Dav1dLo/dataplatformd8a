# rel_modules_langexport

## Source system
Unknown — insufficient evidence. The naming convention `rel_modules_langexport` suggests a relational mapping table, likely from a custom internal application or a modular content management system, but the schema lacks specific vendor-identifying prefixes or patterns.

## Functional process 
This table supports a localization or internationalization (i18n) pipeline. It appears to manage the association between specific modules and their corresponding language export configurations or translation packages, likely used to track which modules are ready for or have undergone language-specific processing.

## Description
One row in this table represents a single association between a wizard configuration (`wiz_id`) and a module (`module_id`). As a staging table, it serves as a raw landed copy of a many-to-many relationship mapping, intended to be joined with parent entities in downstream transformation layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wiz_id | INTEGER | false | Identifier for the wizard configuration | Likely a foreign key to a wizard definition table. |
| module_id | INTEGER | false | Identifier for the module | Likely a foreign key to a module definition table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key on `(wiz_id, module_id)`.
- **Foreign keys (inferred):** 
    - `wiz_id` → `wizards.id` (guess: standard naming convention for wizard-related entities).
    - `module_id` → `modules.id` (guess: standard naming convention for module-related entities).
- **Natural keys (inferred):** The combination of `(wiz_id, module_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table represents a many-to-many relationship; ensure joins are handled correctly to avoid fan-out issues.
- No audit or timestamp columns are present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- The table contains no soft-delete flags; assume this is a snapshot of the current state or a full-load landing table.