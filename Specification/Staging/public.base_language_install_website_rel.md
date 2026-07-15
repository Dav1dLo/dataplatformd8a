# base_language_install_website_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (link tables) between two entities.

## Functional process 
This table supports the configuration of multi-website language availability. It manages the association between specific language installations and the websites on which those languages are enabled, ensuring that the correct localized content is served based on the website context.

## Description
Each row represents a single association between a language installation and a website, effectively mapping which languages are active for which web storefronts. As a staging table, it provides a raw, normalized view of the many-to-many relationship as it exists in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| base_language_install_id | INTEGER | false | Foreign key to the language installation entity | Represents the specific language configuration. |
| website_id | INTEGER | false | Foreign key to the website entity | Identifies the web storefront. |

## Keys

- **Primary key (inferred):** The combination of `(base_language_install_id, website_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `base_language_install_id` → `base_language_install.id` (Inferred from naming convention).
    - `website_id` → `website.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with the parent `base_language_install` and `website` tables to retrieve human-readable names or codes.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- The table contains no sensitive PII, as it only maps internal surrogate identifiers.