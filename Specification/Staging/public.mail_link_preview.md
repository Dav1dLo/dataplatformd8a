# mail_link_preview

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` fields, which are standard audit columns in the Odoo ORM, along with the sequence-based ID generation pattern.

## Functional process 
This table supports the communication and social engagement module, specifically tracking metadata for URLs shared within internal or external messages. It captures Open Graph (OG) protocol data to provide rich previews for links embedded in email or chat threads.

## Description
One row represents a cached metadata record for a specific URL extracted from a message. It serves as a staging entity that stores parsed web content (titles, images, descriptions) to avoid redundant network requests when rendering link previews in the user interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_link_preview_id_seq`. |
| message_id | INTEGER | true | Foreign key to the parent message | Links the preview to a specific communication record. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| source_url | VARCHAR | false | The original URL being previewed | The target web address. |
| og_type | VARCHAR | true | Open Graph object type | e.g., 'website', 'article'. |
| og_title | VARCHAR | true | Open Graph title | The title tag or OG title metadata. |
| og_site_name | VARCHAR | true | Open Graph site name | The name of the source website. |
| og_image | VARCHAR | true | Open Graph image URL | URL path to the preview image. |
| og_mimetype | VARCHAR | true | OG content MIME type | The media type of the OG object. |
| image_mimetype | VARCHAR | true | Image content MIME type | The media type of the preview image. |
| og_description | TEXT | true | Open Graph description | The summary text for the link. |
| is_hidden | BOOLEAN | true | Visibility flag | Indicates if the preview should be suppressed. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id` (Guess: standard Odoo naming convention for message relations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** `source_url` (While not strictly unique in all implementations, it is the business identifier for the content being previewed).

## Caveats for downstream consumers

- **Sensitive Data:** Contains `source_url` which may reveal internal or private link structures.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Data Integrity:** `source_url` is mandatory, but metadata fields (OG tags) are frequently null if the target site does not support Open Graph protocol.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active`), so assume all rows are current unless `is_hidden` is used for that purpose.