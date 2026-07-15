# mail_message_reaction

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mail_message_reaction`), the use of `partner_id` and `guest_id` as common Odoo relational identifiers, and the specific sequence-based default value pattern (`nextval('"public".mail_message_reaction_id_seq'::regclass)`).

## Functional process 
This table supports the internal communication and collaboration module within the ERP. It tracks user-generated reactions (such as emojis or status indicators) attached to specific messages within a communication thread, facilitating social interaction features within the platform's messaging system.

## Description
One row in this table represents a single reaction instance applied by a user or guest to a specific message. This is a raw landing table in the Staging layer, capturing the direct state of reaction records as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mail_message_reaction_id_seq`. |
| message_id | INTEGER | false | Foreign key to the parent message | Links to the message being reacted to. |
| partner_id | INTEGER | true | Foreign key to the internal user/partner | Represents the registered user who reacted. |
| guest_id | INTEGER | true | Foreign key to the guest user | Represents an unauthenticated or guest user who reacted. |
| content | VARCHAR | false | The reaction content | Typically stores the emoji or reaction string. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id` (Inferred from standard Odoo naming patterns for message threads).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming patterns for internal contacts).
    - `guest_id` → `mail_guest.id` (Inferred from standard Odoo naming patterns for guest users).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains a mix of `partner_id` and `guest_id`; queries should handle the logic for identifying the reactor by checking which of these two columns is non-null.
- The `content` column is a `VARCHAR` without a defined length; downstream consumers should be prepared for varying string lengths.
- There is no explicit audit timestamp (e.g., `create_date` or `write_date`) in this schema; temporal analysis of reactions may be limited unless joined with parent message tables.
- Data is stored in its raw state; ensure appropriate handling of potential nulls in the `partner_id` and `guest_id` fields.