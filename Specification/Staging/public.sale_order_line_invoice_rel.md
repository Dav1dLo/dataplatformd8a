# sale_order_line_invoice_rel

## Source system
This table likely originates from an ERP or e-commerce platform (such as Odoo or a custom-built order management system) where invoices are generated against specific order line items. The naming convention `_rel` strongly suggests a junction table used to resolve a many-to-many relationship between order lines and invoice lines.

## Functional process 
This table supports the order-to-cash pipeline by tracking the association between fulfilled order lines and their corresponding billing records. It ensures that financial reporting can trace revenue back to the specific line items of a sales order.

## Description
One row in this table represents a single link between an invoice line and an order line. It serves as a raw, landed join table in the staging layer, facilitating the reconciliation of sales orders against issued invoices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_line_id | INTEGER | false | Foreign key to the invoice line record | Represents the specific line item on an invoice. |
| order_line_id | INTEGER | false | Foreign key to the sales order line record | Represents the specific item requested in the original order. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`invoice_line_id`, `order_line_id`).
- **Foreign keys (inferred):**
    - `invoice_line_id` → `invoice_line.id` (Guess: links to the invoice line detail table).
    - `order_line_id` → `order_line.id` (Guess: links to the sales order line detail table).
- **Natural keys (inferred):** The combination of (`invoice_line_id`, `order_line_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the sequence of creation or deletion from this table alone.
- Ensure that joins to this table are handled carefully to avoid Cartesian products if an order line is partially invoiced across multiple invoices.