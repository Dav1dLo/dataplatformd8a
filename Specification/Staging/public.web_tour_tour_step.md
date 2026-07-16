# web_tour_tour_step

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`web_tour_tour_step`), the use of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific sequence-based default value pattern for the primary key.

## Functional process 
This table supports the "User Onboarding/Guided Tour" process within the web interface. It defines the individual steps that constitute a guided tour, including the trigger conditions, the content displayed to the user, and the execution logic for each step.

## Description
One row in this table represents a single step within a defined guided tour. It acts as a raw landed copy of the Odoo configuration entity, capturing the sequence, trigger event, and instructional content for the step.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `web_tour_tour_step_id_seq`. |
| tour_id | INTEGER | false | Foreign key to the parent tour | Links to the tour definition. |
| sequence | INTEGER | true | Display order of the step | Determines the order of steps in the tour. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| trigger | VARCHAR | false | UI selector or event trigger | The DOM element or event that triggers this step. |
| content | VARCHAR | true | Instructional text | The message displayed to the user. |
| run | VARCHAR | true | JavaScript execution logic | Custom JS code to run during this step. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `tour_id` → `web_tour_tour.id`: This column links the step to its parent tour definition.
    - `create_uid` → `res_users.id`: Standard Odoo audit field referencing the creator.
    - `write_uid` → `res_users.id`: Standard Odoo audit field referencing the last modifier.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag; however, Odoo typically manages record lifecycle via standard audit columns.
- The `trigger`, `content`, and `run` columns may contain HTML or JavaScript snippets; sanitize if rendering in a web context.
- The `VARCHAR` types do not specify length; assume these are unbounded or large text fields typical of Odoo's ORM mapping.