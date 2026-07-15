# bus_presence

## Source system
Unknown — insufficient evidence. The table naming convention and column structure (tracking user/guest presence and polling intervals) are generic and could belong to a variety of internal messaging, collaboration, or real-time tracking applications.

## Functional process 
This table supports a real-time presence or heartbeat monitoring system. It tracks the connectivity status and activity timestamps for both registered users and guests, likely used to power "online/offline" indicators or session management within an application.

## Description
One row in this table represents the current presence state and last known activity timestamp for a specific user or guest. As a staging table, it serves as a raw, landed copy of the application's presence state, capturing the most recent poll and activity events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.bus_presence_id_seq`. |
| user_id | INTEGER | true | Foreign key to the registered user | Nullable if the presence record belongs to a guest. |
| status | VARCHAR | true | Current presence status | Likely values include 'online', 'away', 'offline'. |
| last_poll | TIMESTAMP | true | Timestamp of the last system heartbeat | Indicates when the client last checked in. |
| last_presence | TIMESTAMP | true | Timestamp of the last user activity | Indicates when the user last performed an action. |
| guest_id | INTEGER | true | Identifier for an unauthenticated guest | Nullable if the presence record belongs to a registered user. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `users.id` (guess: standard naming convention for user association).
- **Natural keys (inferred):** 
    - `user_id` (when present) or `guest_id` (when present) act as the business identifiers for the entity being tracked.

## Caveats for downstream consumers

- **PII/Sensitive Data:** While no direct PII is present, the combination of `user_id` and activity timestamps can be used to infer user behavior patterns.
- **Timezone:** Timestamps are stored as `TIMESTAMP` without timezone; assume UTC unless application logs indicate otherwise.
- **Data Integrity:** The table allows both `user_id` and `guest_id` to be null; ensure queries handle cases where neither or both might be populated if the source system allows inconsistent state.
- **Soft Deletes:** No explicit soft-delete flag is present; assume this table represents the current state (latest snapshot) of presence.