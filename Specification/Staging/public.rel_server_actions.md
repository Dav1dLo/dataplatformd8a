# rel_server_actions

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between servers and actions, but there are no specific prefixes or naming conventions (such as `kunnr` or `stripe_`) to definitively link this to a specific SaaS or ERP platform.

## Functional process 
This table supports a many-to-many relationship management process, likely tracking which administrative or automated actions are permitted, assigned, or have been executed on specific server instances. It acts as a join table to resolve the association between server entities and action definitions.

## Description
One row in this table represents a single association between a specific server and a specific action. As a staging table, it serves as a raw landed copy of the relationship mapping, intended to be used for joining server metadata with action logs or configuration tables in downstream layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| server_id | INTEGER | false | Unique identifier for the server entity. | Foreign key reference to a server master table. |
| action_id | INTEGER | false | Unique identifier for the action entity. | Foreign key reference to an action definition table. |

## Keys

- **Primary key (inferred):** The combination of `(server_id, action_id)` is inferred as the composite primary key.
- **Foreign keys (inferred):** 
    - `server_id` → `servers.id` (guess: standard naming convention for server entities).
    - `action_id` → `actions.id` (guess: standard naming convention for action definitions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; ensure that joins to downstream dimensions account for the potential fan-out if joining on only one of the two columns.
- There are no audit timestamps (e.g., `created_at`) present in this staging table; it is impossible to determine the temporal validity of these relationships from this source alone.
- No soft-delete flags are present; assume this table represents the current state of associations as captured during the last ingestion.