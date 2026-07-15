# crm_lead_website_visitor_rel

## Source system
Unknown — insufficient evidence. While the naming convention suggests a relationship between a CRM lead entity and a website visitor tracking system, the lack of a specific vendor prefix (e.g., "sf_", "hubspot_") makes it impossible to attribute this to a specific operational system.

## Functional process 
This table supports the lead attribution and tracking process. It maps anonymous website visitor sessions to identified CRM leads, enabling the business to correlate web browsing behavior with sales pipeline activities.

## Description
This table represents a many-to-many join relationship between CRM leads and website visitors. It serves as a raw landing copy of the association table, capturing the link between a unique lead identifier and a unique visitor identifier at the grain of one row per association.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_id | INTEGER | false | Foreign key to the CRM lead record | Represents the identity of the lead in the source CRM. |
| website_visitor_id | INTEGER | false | Foreign key to the website visitor record | Represents the identity of the visitor in the web tracking platform. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key on (`crm_lead_id`, `website_visitor_id`).
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_leads.id` (guess: standard naming convention for lead entities).
    - `website_visitor_id` → `website_visitors.id` (guess: standard naming convention for visitor entities).
- **Natural keys (inferred):** The combination of (`crm_lead_id`, `website_visitor_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or metadata columns (e.g., `created_at`), making it difficult to determine the sequence of associations or identify when a link was established.
- There are no soft-delete flags; assume that the absence of a record implies the relationship does not exist or has been purged.
- As a staging table, this may contain orphaned records if referential integrity is not enforced at the source system level.