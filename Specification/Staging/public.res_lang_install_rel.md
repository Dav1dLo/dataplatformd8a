# res_lang_install_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_lang_install_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link base resources (in this case, language installation wizards and specific language definitions).

## Functional process 
This table supports the localization and internationalization configuration process within the ERP. It tracks which specific languages have been selected or processed through a language installation wizard, facilitating the multi-language support features of the platform.

## Description
One row in this table represents a single association between a language installation wizard instance and a specific language record. It serves as a raw landing copy of the join table used to manage the many-to-many relationship between language configuration tools and the system's supported language library.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| language_wizard_id | INTEGER | false | Foreign key to the language installation wizard | Links to the specific wizard session. |
| lang_id | INTEGER | false | Foreign key to the language definition | Identifies the language being installed or configured. |

## Keys

- **Primary key (inferred):** The combination of `(language_wizard_id, lang_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `language_wizard_id` → `base_language_install_wizard.id` (Guess: standard Odoo naming convention for wizard relations).
    - `lang_id` → `res_lang.id` (Guess: standard Odoo naming convention for language definitions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; tracking the creation time of these relationships is not possible from this source alone.
- As a standard Odoo `_rel` table, it is strictly structural and does not contain PII.