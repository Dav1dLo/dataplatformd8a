# product_template

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming conventions (e.g., `categ_id`, `uom_id`, `write_uid`, `JSONB` fields for multi-language support) and the specific functional modules (POS, purchase, sale, inventory) are characteristic of the Odoo ORM structure.

## Functional process 
This table supports the Product Lifecycle Management and Catalog Management processes. It serves as the master definition for products, defining their attributes, pricing, and behavior across sales, purchasing, and inventory modules. It acts as the central hub for product configuration, linking to categories, units of measure, and accounting properties.

## Description
One row in this table represents a single product template, which defines the core characteristics and business rules for a product or a family of product variants. This is a raw landed copy from the Odoo staging layer, capturing the full configuration state of the product catalog. It serves as the primary source of truth for product metadata before any downstream transformations into dimensional models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Internal surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order sequence | Used for UI sorting. |
| categ_id | INTEGER | false | Product category foreign key | Links to product category hierarchy. |
| uom_id | INTEGER | false | Unit of measure foreign key | Default unit for the product. |
| uom_po_id | INTEGER | false | Purchase unit of measure foreign key | Unit used for purchasing. |
| company_id | INTEGER | true | Owning company ID | Null if shared across all companies. |
| color | INTEGER | true | UI color index | Used for Kanban/UI display. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for updates. |
| type | VARCHAR | false | Product type | e.g., 'consu', 'service', 'product'. |
| service_tracking | VARCHAR | false | Service tracking policy | Defines how services are tracked. |
| default_code | VARCHAR | true | Internal reference/SKU | The business-facing product code. |
| name | JSONB | false | Product name | Multi-language support. |
| description | JSONB | true | General description | Multi-language support. |
| description_purchase | JSONB | true | Purchase description | Multi-language support. |
| description_sale | JSONB | true | Sale description | Multi-language support. |
| product_properties | JSONB | true | Dynamic product attributes | Flexible key-value storage. |
| list_price | NUMERIC | true | Sales price | Currency units. |
| volume | NUMERIC | true | Product volume | Physical dimension. |
| weight | NUMERIC | true | Product weight | Physical dimension. |
| sale_ok | BOOLEAN | true | Can be sold | Flag for sales availability. |
| purchase_ok | BOOLEAN | true | Can be purchased | Flag for procurement availability. |
| active | BOOLEAN | true | Soft-delete status | False indicates archived product. |
| can_image_1024_be_zoomed | BOOLEAN | true | Image zoom capability | UI-specific flag. |
| has_configurable_attributes | BOOLEAN | true | Variant configuration flag | Indicates if product has variants. |
| is_favorite | BOOLEAN | true | User favorite flag | UI-specific flag. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| property_account_income_id | JSONB | true | Income account mapping | Accounting configuration. |
| property_account_expense_id | JSONB | true | Expense account mapping | Accounting configuration. |
| sale_delay | INTEGER | true | Lead time for sales | Days. |
| tracking | VARCHAR | false | Serial/Lot tracking policy | e.g., 'none', 'serial', 'lot'. |
| responsible_id | JSONB | true | Product manager/responsible | User reference. |
| property_stock_production | JSONB | true | Production location | Inventory configuration. |
| property_stock_inventory | JSONB | true | Inventory location | Inventory configuration. |
| description_picking | JSONB | true | Picking description | Multi-language support. |
| description_pickingout | JSONB | true | Outbound picking description | Multi-language support. |
| description_pickingin | JSONB | true | Inbound picking description | Multi-language support. |
| is_storable | BOOLEAN | true | Stockable product flag | Determines inventory management. |
| purchase_method | VARCHAR | true | Purchase invoicing policy | e.g., 'purchase', 'receive'. |
| purchase_line_warn | VARCHAR | false | Purchase warning policy | e.g., 'no-message', 'warning'. |
| purchase_line_warn_msg | TEXT | true | Purchase warning text | User-facing warning. |
| lot_valuated | BOOLEAN | true | Lot valuation flag | Accounting/Inventory setting. |
| public_description | JSONB | true | E-commerce description | Multi-language support. |
| available_in_pos | BOOLEAN | true | POS availability flag | Used for Point of Sale. |
| to_weight | BOOLEAN | true | Weighing scale flag | Used for POS/Retail. |
| property_account_creditor_price_difference | JSONB | true | Price diff account | Accounting configuration. |
| service_type | VARCHAR | true | Service type | e.g., 'manual', 'timesheet'. |
| sale_line_warn | VARCHAR | false | Sales warning policy | e.g., 'no-message', 'warning'. |
| expense_policy | VARCHAR | true | Expense invoicing policy | e.g., 'no', 'cost', 'sales_price'. |
| invoice_policy | VARCHAR | true | Invoicing policy | e.g., 'order', 'delivery'. |
| sale_line_warn_msg | TEXT | true | Sales warning text | User-facing warning. |
| service_to_purchase | JSONB | true | Service purchase link | Configuration. |
| project_id | JSONB | true | Linked project ID | Project management link. |
| project_template_id | JSONB | true | Linked project template | Project management link. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `categ_id` → `product_category.id` (Standard Odoo category link)
    - `uom_id` → `uom_uom.id` (Standard Odoo unit of measure link)
    - `uom_po_id` → `uom_uom.id` (Standard Odoo purchase unit of measure link)
- **Natural keys (inferred):** 
    - `default_code` (Internal reference/SKU, though not strictly enforced as unique in all Odoo versions)

## Caveats for downstream consumers

- **Soft Deletes:** Use the `active` column to filter out archived products.
- **JSONB Fields:** Many fields (e.g., `name`, `description`, `property_*`) are stored as `JSONB`. These often contain language-specific dictionaries (e.g., `{"en_US": "Product Name", "fr_FR": "Nom du produit"}`). You will need to extract the relevant key for your reporting.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **PII/Sensitive Data:** No direct PII, but `responsible_id` and user-related IDs link to internal employee/user records which may contain sensitive HR data.
- **Data Grain:** This table represents the "Template" level. If you need specific variants (e.g., size/color combinations), you must join this with the `product_product` table.