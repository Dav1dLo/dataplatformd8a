# onboarding_progress_onboarding_progress_step_rel

## Source system
This table originates from a relational database, likely a custom-built application backend or a SaaS platform using a PostgreSQL database. The naming convention `_rel` strongly suggests a join table used to manage a many-to-many relationship between onboarding progress records and specific onboarding steps.

## Functional process 
This table supports the user onboarding lifecycle management process. It tracks the association between a specific user's onboarding progress instance and the individual steps that have been completed or are currently in scope for that progress instance.

## Description
One row in this table represents a single association between an onboarding progress record and a specific onboarding step. It serves as a raw landed junction table in the staging layer, capturing the link between the progress entity and its constituent steps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| onboarding_progress_id | INTEGER | false | Foreign key to the onboarding progress entity | Represents the parent onboarding session. |
| onboarding_progress_step_id | INTEGER | false | Foreign key to the specific onboarding step | Represents the individual task or milestone. |

## Keys

- **Primary key (inferred):** The composite of `(onboarding_progress_id, onboarding_progress_step_id)`.
- **Foreign keys (inferred):** 
    - `onboarding_progress_id` → `onboarding_progress.id`: This column links to the main onboarding progress record.
    - `onboarding_progress_step_id` → `onboarding_progress_step.id`: This column links to the definition of the onboarding step.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect many-to-many relationships between progress and steps.
- There are no timestamps or audit columns present; it is impossible to determine the sequence or timing of step completion from this table alone.
- No sensitive PII is contained within this table.
- As a staging table, this may contain orphaned records if the upstream source system does not enforce strict referential integrity.