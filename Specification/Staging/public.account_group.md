# account_group

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` alongside a `JSONB` column for the name (typically used for multi-language support) is a signature pattern of the Odoo ORM framework.

## Functional process 
This table supports the Chart of Accounts configuration process. It defines hierarchical groupings for financial accounts, allowing users to aggregate account balances based on code prefixes (e.g., grouping all accounts starting with '100' to '199' under a specific header).

## Description
Each row represents a single account group within a company's financial structure. This table acts as a raw landed copy of the Odoo `account.group` model, maintaining the hierarchical relationship between parent and child groups. It is used to build the tree structure of the financial reporting hierarchy.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `account_group_id_seq`. |
| parent_id | INTEGER | true | Self-referencing foreign key to the parent group | Null if the group is at the root level. |
| company_id | INTEGER | false | Foreign key to the owning company | Links the group to a specific legal entity. |
| create_uid | INTEGER | true | ID of the user who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the `res_users` table. |
| code_prefix_start | VARCHAR | true | Starting range of account codes | Used for grouping logic. |
| code_prefix_end | VARCHAR | true | Ending range of account codes | Used for grouping logic. |
| name | JSONB | false | Display name of the group | Likely contains localized strings (e.g., `{"en_US": "Assets"}`). |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `parent_id` → `public.account_group.id`: Establishes the recursive tree structure of the account groups.
    - `company_id` → `public.res_company.id`: Links the group to the specific company context (guess based on Odoo standard schema).
    - `create_uid` / `write_uid` → `public.res_users.id`: Tracks the system users responsible for the record lifecycle (guess based on Odoo standard schema).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** No direct PII, but contains internal system metadata.
- **Timestamps:** Assumed to be in UTC as per standard Odoo configuration.
- **JSONB Handling:** The `name` column is `JSONB`; downstream consumers will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by Odoo's internal logic.
- **Hierarchy:** Queries traversing the `parent_id` will require a Recursive Common Table Expression (CTE) to fully resolve the tree depth.