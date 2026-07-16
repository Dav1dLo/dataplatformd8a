# res_partner_res_partner_category_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_partner_res_partner_category_rel` is a standard pattern used by Odoo's ORM to manage many-to-many relationship tables (often called "relation tables") between the `res_partner` (customer/contact) and `res_partner_category` (tag/label) entities.

## Functional process 
This table supports the customer relationship management (CRM) and contact categorization process. It maps business partners to specific categories or tags, allowing for segmented marketing, reporting, or filtering of contacts based on assigned labels.

## Description
One row in this table represents a single association between a specific business partner and a specific category. It is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo database's relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| category_id | INTEGER | false | Foreign key to the category definition | Links to the primary key of the category table. |
| partner_id | INTEGER | false | Foreign key to the partner/contact | Links to the primary key of the partner table. |

## Keys

- **Primary key (inferred):** The composite key `(category_id, partner_id)` is the inferred primary key, as it represents the unique link between the two entities.
- **Foreign keys (inferred):** 
    - `category_id` → `res_partner_category.id`: This column references the unique identifier for a partner category.
    - `partner_id` → `res_partner.id`: This column references the unique identifier for a business partner.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that joins to the parent tables (`res_partner` and `res_partner_category`) handle potential orphan records if the upstream ingestion process is not perfectly synchronized.