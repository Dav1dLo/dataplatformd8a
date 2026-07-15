# ir_profile

## Source system
This table originates from an Odoo ERP environment. The naming convention `ir_profile` (Internal Registry profile) and the presence of columns like `sql`, `init_stack_trace`, `qweb`, and `traces_sync` are characteristic of Odoo's internal performance profiling and debugging tools used to track request execution and database query performance.

## Functional process 
This table supports system performance monitoring and diagnostic logging. It captures execution metrics for specific application requests or sessions, allowing developers to analyze bottlenecks in SQL query execution, template rendering (`qweb`), and asynchronous/synchronous process traces.

## Description
One row in this table represents a single performance profile event or request execution trace. It acts as a raw landing record for diagnostic data, capturing the duration, associated SQL queries, and stack traces generated during a specific application session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_profile_id_seq`. |
| sql_count | INTEGER | true | Total number of SQL queries executed | Useful for identifying N+1 query issues. |
| entry_count | INTEGER | true | Number of entries/records processed | Context depends on the specific profile event. |
| session | VARCHAR | true | Identifier for the user or system session | Likely maps to an Odoo session token. |
| name | VARCHAR | true | Name or label of the profiled event | Often describes the action or controller being profiled. |
| init_stack_trace | TEXT | true | Initial stack trace of the profiled process | Used for debugging the origin of the request. |
| sql | TEXT | true | Captured SQL query statements | May contain multiple statements; check for serialization format. |
| traces_async | TEXT | true | Asynchronous execution traces | JSON or serialized string format. |
| traces_sync | TEXT | true | Synchronous execution traces | JSON or serialized string format. |
| qweb | TEXT | true | QWeb template rendering performance data | Specific to Odoo's QWeb engine. |
| create_date | TIMESTAMP | true | Timestamp of the profile event | Assumed UTC. |
| duration | DOUBLE PRECISION | true | Total execution time | Unit is typically seconds. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** Not confidently inferable from the provided metadata.
- **Natural keys (inferred):** Not confidently inferable; the table appears to be a log of events rather than a business entity with a unique natural key.

## Caveats for downstream consumers

- **Sensitive Data:** The `sql` and `init_stack_trace` columns may contain sensitive information, including raw data values, table names, or internal file paths. Masking is recommended.
- **Timezone:** `create_date` is assumed to be in UTC, but verify against Odoo system configuration.
- **Data Format:** Columns like `sql`, `traces_async`, `traces_sync`, and `qweb` contain `TEXT` blobs that likely store serialized JSON or structured logs; these will require parsing before analysis.
- **Retention:** As a staging/logging table, it may be subject to truncation or high-volume ingestion; ensure queries account for potential duplicates or partial data.