# ir_model_inherit

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_inherit` is a standard internal table in the Odoo "Ir" (Information Repository) module, which manages the object-relational mapping (ORM) and inheritance structure of the application's data models.

## Functional process 
This table supports the Odoo ORM's model inheritance mechanism. It tracks how different data models (e.g., `res.partner`, `sale.order`) inherit fields and behaviors from parent models, enabling the modular extension of business objects within the ERP.

## Description
One row in this table represents a single inheritance relationship between two Odoo data models, where one model extends another. It serves as a raw metadata record within the staging layer, capturing the structural dependencies defined in the application's ORM layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_model_inherit_id_seq`. |
| model_id | INTEGER | false | Foreign key to the child model | References `ir_model.id`. |
| parent_id | INTEGER | false | Foreign key to the parent model | References `ir_model.id`. |
| parent_field_id | INTEGER | true | Foreign key to the specific field | References `ir_model_fields.id` if the inheritance is linked to a specific field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id`: Identifies the model that is inheriting properties.
    - `parent_id` → `ir_model.id`: Identifies the model being inherited from.
    - `parent_field_id` → `ir_model_fields.id`: Identifies the specific field that triggers or defines the inheritance link (guess).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains structural metadata for the ERP application; it does not contain transactional business data.
- The `parent_field_id` is frequently null, as not all inheritance relationships are tied to a specific field definition.
- As a staging table, this reflects the raw state of the Odoo metadata; ensure joins to `ir_model` are handled carefully as these IDs are internal to the Odoo instance and may change if the database is re-initialized.