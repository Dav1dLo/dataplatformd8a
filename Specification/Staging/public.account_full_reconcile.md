# account_full_reconcile

## Source system
This table originates from an Odoo ERP system. The naming convention `account_full_reconcile` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo accounting module's reconciliation engine.

## Functional process 
This table supports the financial reconciliation process, specifically tracking the full matching of accounting entries. It links specific ledger movements to reconciliation events, ensuring that debits and credits are balanced and marked as "fully reconciled" within the general ledger.

## Description
One row in this table represents a single full reconciliation event that groups multiple accounting entries together. It serves as a raw landed copy of the Odoo `account.full.reconcile` model, providing the audit trail for when and by whom a set of ledger entries were reconciled.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| exchange_move_id | INTEGER | true | Foreign key to account_move | Links to the exchange rate difference journal entry if applicable. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res_users; identifies who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res_users; identifies who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `exchange_move_id` → `account_move.id`: Links to the journal entry created for currency exchange differences.
    - `create_uid` → `res_users.id`: Identifies the system user who performed the reconciliation.
    - `write_uid` → `res_users.id`: Identifies the system user who last modified the reconciliation record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Audit Columns:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement soft deletes; records are typically permanent once a reconciliation is finalized.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user metadata which may contain sensitive information in the source system.
- **Data Integrity:** `exchange_move_id` is nullable because not all reconciliations result in an exchange rate difference entry (e.g., reconciliations within the same currency).