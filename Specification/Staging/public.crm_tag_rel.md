# crm_tag_rel

## Source system
The table likely originates from a CRM system (such as Salesforce, HubSpot, or a custom-built lead management application). The naming convention `crm_tag_rel` strongly suggests a junction table used to manage many-to-many relationships between lead records and descriptive tags or categories.

## Functional process 
This table supports lead segmentation and categorization processes. It enables the association of multiple descriptive labels (tags) to a single lead, allowing marketing and sales teams to filter, group, and target leads based on specific attributes or campaign interests.

## Description
One row in this table represents a single association between a lead and a tag. It serves as a raw landing copy of a junction table, maintaining the link between lead entities and their assigned metadata tags at the grain of one row per unique lead-tag pair.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| lead_id | INTEGER | false | Unique identifier for the lead | Foreign key to the leads table. |
| tag_id | INTEGER | false | Unique identifier for the tag | Foreign key to the tags definition table. |

## Keys

- **Primary key (inferred):** Composite key of (`lead_id`, `tag_id`).
- **Foreign keys (inferred):** 
    - `lead_id` → `leads.id`: This column references the primary identifier of a lead record.
    - `tag_id` → `tags.id`: This column references the primary identifier of a tag definition record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect a many-to-many relationship between leads and tags.
- There are no timestamps or audit columns provided; it is impossible to determine the creation date of these associations from this table alone.
- Ensure that joins to parent tables (`leads` or `tags`) handle potential orphans if referential integrity is not strictly enforced in the source system.