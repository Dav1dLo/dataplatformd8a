# team_favorite_user_rel

## Source system
The source system is likely an internal application database, possibly a custom-built web application or a SaaS platform backend. The naming convention `_rel` (relationship) and the pairing of `team_id` and `user_id` are characteristic of a junction table used to manage many-to-many associations in a relational database.

## Functional process 
This table supports user-preference management or social features within the application. It tracks which users have "favorited" or "followed" specific teams, enabling personalized feeds, notifications, or dashboard filtering based on user-selected team interests.

## Description
One row in this table represents a single association between a user and a team they have marked as a favorite. As a staging table, it serves as a raw, landed copy of the relationship mapping from the source operational database, intended to be used for building downstream user-interest dimensions or activity fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| team_id | INTEGER | false | Unique identifier for the team. | Foreign key to the teams master table. |
| user_id | INTEGER | false | Unique identifier for the user. | Foreign key to the users master table. |

## Keys

- **Primary key (inferred):** (`team_id`, `user_id`) as a composite key.
- **Foreign keys (inferred):** 
    - `team_id` → `teams.id` (inferred from naming convention).
    - `user_id` → `users.id` (inferred from naming convention).
- **Natural keys (inferred):** The combination of (`team_id`, `user_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There is no audit timestamp (e.g., `created_at`) provided in the source metadata, so it is impossible to determine when the relationship was established.
- The table does not appear to use a surrogate primary key, relying instead on the composite natural key.
- Ensure inner joins are used when filtering by existing users or teams to avoid orphaned records if referential integrity is not strictly enforced in the source.