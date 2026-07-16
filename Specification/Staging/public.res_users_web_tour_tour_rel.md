# res_users_web_tour_tour_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_web_tour_tour_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core user records (`res_users`) to web tour progress or configuration entities.

## Functional process 
This table supports the user onboarding and guided tour tracking process. It maps which users have interacted with or are assigned to specific web tours within the application interface, facilitating the tracking of tutorial completion or feature discovery status.

## Description
One row represents a single association between a user and a specific web tour. This is a raw landing copy of a join table, used to resolve the many-to-many relationship between the `res_users` and `web_tour_tour` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| web_tour_tour_id | INTEGER | false | Foreign key to the web tour definition | Links to the primary key of the tour entity. |
| res_users_id | INTEGER | false | Foreign key to the user record | Links to the primary key of the `res_users` table. |

## Keys

- **Primary key (inferred):** The composite key `(web_tour_tour_id, res_users_id)`.
- **Foreign keys (inferred):** 
    - `web_tour_tour_id` → `web_tour_tour.id`: This column references the tour definition table.
    - `res_users_id` → `res_users.id`: This column references the system user table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when the relationship was created or modified from this table alone.
- Ensure that joins to `res_users` or `web_tour_tour` account for potential orphan records if referential integrity is not strictly enforced at the database level in the source system.