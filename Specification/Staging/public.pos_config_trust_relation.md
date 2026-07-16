# pos_config_trust_relation

## Source system
The source system is likely an internal configuration or access management module within a custom-built application or an ERP system (such as Odoo or a similar modular framework). The naming convention `pos_config` suggests this relates to Point of Sale (POS) system settings or inter-service trust configurations.

## Functional process 
This table supports the management of trust relationships between system entities or configuration nodes. It defines a directed graph of trust, where one entity (`is_trusting`) grants or establishes a trust relationship with another entity (`is_trusted`), likely to facilitate cross-service authentication, data sharing, or administrative permissions.

## Description
One row in this table represents a single directed trust link between two entities identified by their integer IDs. This is a raw landing table in the Staging layer, capturing the current state of trust associations as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| is_trusting | INTEGER | false | The ID of the entity initiating the trust. | Represents the subject of the trust relationship. |
| is_trusted | INTEGER | false | The ID of the entity being trusted. | Represents the object of the trust relationship. |

## Keys

- **Primary key (inferred):** The composite of (`is_trusting`, `is_trusted`) is the inferred primary key, as a trust relationship is typically unique per pair.
- **Foreign keys (inferred):** 
    - `is_trusting` → `pos_config.id` (guess): Likely references a configuration entity ID.
    - `is_trusted` → `pos_config.id` (guess): Likely references a configuration entity ID.
- **Natural keys (inferred):** The pair (`is_trusting`, `is_trusted`) acts as the natural business key for the relationship.

## Caveats for downstream consumers

- This table represents a many-to-many relationship stored as an adjacency list.
- There are no timestamps or audit columns; it is impossible to determine when a trust relationship was created or modified from this table alone.
- The table does not explicitly define the type of trust (e.g., read-only vs. full access); downstream consumers should check if a separate metadata table defines the "level" of trust.
- The `INTEGER` types are assumed to be standard 32-bit integers; verify against source DDL if IDs exceed 2.1 billion.