# ir_sequence_date_range

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_sequence_*` is characteristic of Odoo's internal registry (IR) module, which manages document numbering sequences (e.g., invoice or purchase order numbers) that reset or change based on specific date ranges.

## Functional process 
This table supports the document numbering and sequence management process. It defines time-bound segments for sequences, allowing the system to track the "next number" (`number_next`) to be assigned to a business document within a specific `date_from` and `date_to` window.

## Description
One row in this table represents a specific date-based configuration for a document sequence, defining the starting number for a given period. It serves as a raw landed copy of the Odoo configuration table, used to maintain continuity in sequential document identifiers across fiscal or calendar periods.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing ID from sequence generator. |
| sequence_id | INTEGER | false | Foreign key to the parent sequence | Links to the main sequence definition. |
| number_next | INTEGER | false | Next sequence number | The value to be assigned to the next document. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this range. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this range. |
| date_from | DATE | false | Start date of range | Inclusive start date for this sequence segment. |
| date_to | DATE | false | End date of range | Inclusive end date for this sequence segment. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone usually UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone usually UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sequence_id` → `ir_sequence.id`: This column links the date range configuration to the primary sequence definition.
    - `create_uid` → `res_users.id`: Likely references the user who created the record.
    - `write_uid` → `res_users.id`: Likely references the user who last modified the record.
- **Natural keys (inferred):** 
    - `(sequence_id, date_from, date_to)`: The combination of the sequence and the date boundaries uniquely identifies a configuration segment.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored as `TIMESTAMP` without timezone; assume UTC unless otherwise specified by Odoo instance configuration.
- **Data Integrity:** This is a staging table; verify that `number_next` is not being updated concurrently by the application before relying on it for real-time document generation.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in these configuration tables; records are usually hard-deleted or updated in place.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user metadata which may be sensitive.