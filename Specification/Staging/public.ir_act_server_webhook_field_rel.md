# ir_act_server_webhook_field_rel

## Source system
This table originates from Odoo (OpenERP), as indicated by the `ir_act_server_` naming convention, which is the standard prefix for Odoo's "Server Actions" framework. The `_rel` suffix denotes a standard many-to-many join table used by the Odoo ORM to link server actions to specific field definitions.

## Functional process 
This table supports the configuration of automated server actions, specifically those involving webhooks or data processing tasks that require mapping to specific model fields. It facilitates the relationship between a server action definition and the fields it interacts with or updates during execution.

## Description
One row in this table represents a single association between a server action and a field. It acts as a junction table to resolve a many-to-many relationship, ensuring that a specific server action can be mapped to multiple fields, and a field can be referenced by multiple server actions. This is a raw landing of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| server_id | INTEGER | false | Foreign key to the server action definition | Links to `ir_act_server.id`. |
| field_id | INTEGER | false | Foreign key to the field definition | Links to `ir_model_fields.id`. |

## Keys

- **Primary key (inferred):** The composite key `(server_id, field_id)`.
- **Foreign keys (inferred):** 
    - `server_id` → `ir_act_server.id`: This column references the primary identifier of the server action entity.
    - `field_id` → `ir_model_fields.id`: This column references the primary identifier of the model field entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; updates to these relationships are typically handled by the Odoo ORM via `INSERT` and `DELETE` operations.
- Ensure that joins to `ir_act_server` and `ir_model_fields` are performed using `INNER JOIN` if you only require active relationships, as this table does not maintain historical state.