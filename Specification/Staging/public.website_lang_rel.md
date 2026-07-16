# website_lang_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relational mapping between websites and languages, which is common in custom-built CMS or multi-tenant web applications. It lacks specific vendor-identifying prefixes or naming conventions (e.g., `sf_`, `sap_`, `stripe_`).

## Functional process 
This table supports multi-language configuration management for web properties. It defines the association between specific website entities and the languages enabled or supported for those sites, likely used to drive localization settings or content availability filters.

## Description
One row represents a single association between a website and a supported language. This is a raw landing table in the Staging layer, serving as a junction table to resolve a many-to-many relationship between websites and languages.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_id | INTEGER | false | Surrogate key for the website entity | Likely references a parent website table. |
| lang_id | INTEGER | false | Surrogate key for the language entity | Likely references a master language lookup table. |

## Keys

- **Primary key (inferred):** (`website_id`, `lang_id`) — The combination of both columns is required to uniquely identify the relationship.
- **Foreign keys (inferred):** 
    - `website_id` → `websites.id` (guess: standard naming convention for parent-child relationship).
    - `lang_id` → `languages.id` (guess: standard naming convention for lookup table reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `created_at` or `updated_at`) present, so incremental loading logic cannot rely on row-level metadata.
- The table structure implies a many-to-many relationship; ensure joins to downstream dimensions account for potential fan-out if filtering is not applied correctly.