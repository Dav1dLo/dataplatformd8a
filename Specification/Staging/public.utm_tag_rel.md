# utm_tag_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between UTM tags and marketing campaigns, which is common in custom-built marketing attribution databases or internal tracking systems. There is no specific vendor signature (e.g., Salesforce, HubSpot) present in the naming convention.

## Functional process 
This table supports the marketing attribution and campaign management process. It acts as a bridge (associative entity) to facilitate a many-to-many relationship between marketing campaign definitions and specific UTM tracking tags used for performance monitoring.

## Description
One row in this table represents a single association between a specific campaign and a specific UTM tag. It serves as a raw landing copy of the relationship mapping, ensuring that multiple tags can be attributed to a single campaign and vice versa.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| tag_id | INTEGER | false | Surrogate key for the UTM tag | Foreign key reference to the tags dimension. |
| campaign_id | INTEGER | false | Surrogate key for the marketing campaign | Foreign key reference to the campaigns dimension. |

## Keys

- **Primary key (inferred):** Not confidently inferable. While this is a bridge table, it lacks a surrogate primary key column; it is likely a composite primary key on (`tag_id`, `campaign_id`).
- **Foreign keys (inferred):** 
    - `tag_id` → `tags.id` (Guess: standard naming convention for tag-related entities).
    - `campaign_id` → `campaigns.id` (Guess: standard naming convention for campaign-related entities).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a bridge entity; ensure joins to parent tables are handled as inner joins if you require complete metadata for both the tag and the campaign.
- No audit timestamps (e.g., `created_at`) are present; it is impossible to determine the temporal validity of these associations from this table alone.
- There is no soft-delete flag; assume that the absence of a record implies the association does not exist or has been purged.