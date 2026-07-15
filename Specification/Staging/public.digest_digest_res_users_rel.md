# digest_digest_res_users_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `_rel` combined with the prefix `digest_digest` and `res_users` is characteristic of Odoo's automated many-to-many relationship tables, which link core business objects (in this case, Digest emails) to system users.

## Functional process 
This table supports the "Digest Email Subscription" process. It manages the many-to-many relationship between digest configurations (which define what metrics are sent) and the system users who are subscribed to receive those specific digest reports.

## Description
One row in this table represents a single association between a specific digest configuration and a user who is subscribed to it. As a staging table, it acts as a raw, normalized link table representing the join between the `digest_digest` and `res_users` entities. It serves as the source for downstream models that track user-level notification preferences.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| digest_digest_id | INTEGER | false | Foreign key to the digest configuration | Links to the primary key of the digest definition. |
| res_users_id | INTEGER | false | Foreign key to the system user | Links to the primary key of the user record. |

## Keys

- **Primary key (inferred):** The combination of `(digest_digest_id, res_users_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `digest_digest_id` → `digest_digest.id`: This column references the parent digest configuration record.
    - `res_users_id` → `res_users.id`: This column references the user record associated with the digest.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only the relationship identifiers.
- There are no timestamps or audit columns present; incremental loading logic must rely on the upstream source system's change tracking or full-table replacement.
- Ensure that joins to `res_users` account for potential soft-deleted users if the upstream system supports them, as this table may contain orphaned references if not cleaned by the source application.