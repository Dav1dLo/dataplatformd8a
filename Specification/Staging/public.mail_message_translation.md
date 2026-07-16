# mail_message_translation

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the sequence-based default value for the primary key, which are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the multi-language communication module within the ERP, specifically the translation of email templates or message bodies. It tracks localized versions of content linked to a master message record, facilitating the delivery of communications in the recipient's preferred language.

## Description
One row in this table represents a single translated version of a specific email message body. It serves as a raw landing copy of the translation records, capturing the source and target language mapping along with the translated text content.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_message_translation_id_seq`. |
| message_id | INTEGER | false | Foreign key to the parent message | Links to the master message record. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| source_lang | VARCHAR | false | ISO language code of the source | e.g., 'en_US'. |
| target_lang | VARCHAR | false | ISO language code of the target | e.g., 'fr_FR'. |
| body | TEXT | false | The translated message content | Contains the actual HTML or text body. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id`: This column links the translation to the specific email message being translated.
    - `create_uid` → `res_users.id`: Tracks the user responsible for the initial translation entry.
    - `write_uid` → `res_users.id`: Tracks the user responsible for the last modification.
- **Natural keys (inferred):** 
    - The combination of `message_id`, `source_lang`, and `target_lang` likely acts as the business key for a specific translation instance.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** The `body` column may contain PII or sensitive business communication; ensure appropriate masking if exposing to non-authorized users.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed physically if deleted in the source.
- **Precision:** `VARCHAR` lengths for language codes are not explicitly defined in the metadata; expect standard 5-character codes (e.g., `en_US`).