# pos_config

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `pos_config`, `picking_type_id`, `journal_id`, `create_uid`) and the specific boolean flags for POS hardware interfaces are characteristic of the Odoo Point of Sale module's configuration schema.

## Functional process 
This table supports the Point of Sale (POS) management process, specifically defining the operational parameters for individual POS terminals or shops. It governs how a POS session behaves, including hardware integration (printers, scales, cash drawers), accounting integration (journals, fiscal positions), and user access controls.

## Description
One row in this table represents a single Point of Sale configuration profile, defining the settings and hardware associations for a specific POS terminal. It serves as the primary configuration entity in the staging layer, capturing the state of the POS environment as defined in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence generated. |
| picking_type_id | INTEGER | false | ID of the picking type for stock moves | Links to stock.picking.type. |
| journal_id | INTEGER | true | Default accounting journal | Used for POS session entries. |
| invoice_journal_id | INTEGER | true | Journal for customer invoices | Used when generating invoices. |
| sequence_id | INTEGER | true | Sequence for order numbering | Links to ir.sequence. |
| sequence_line_id | INTEGER | true | Sequence for order line numbering | Links to ir.sequence. |
| pricelist_id | INTEGER | true | Default pricelist | Links to product.pricelist. |
| company_id | INTEGER | false | Owning company ID | Links to res.company. |
| group_pos_manager_id | INTEGER | true | Manager access group | Links to res.groups. |
| group_pos_user_id | INTEGER | true | User access group | Links to res.groups. |
| tip_product_id | INTEGER | true | Product used for tips | Links to product.product. |
| default_fiscal_position_id | INTEGER | true | Default tax mapping | Links to account.fiscal.position. |
| rounding_method | INTEGER | true | Cash rounding method ID | Links to account.cash.rounding. |
| warehouse_id | INTEGER | true | Associated warehouse | Links to stock.warehouse. |
| route_id | INTEGER | true | Preferred logistics route | Links to stock.location.route. |
| create_uid | INTEGER | true | Creator user ID | Links to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Links to res.users. |
| access_token | VARCHAR | true | Security token for remote access | Used for external API/proxy calls. |
| name | VARCHAR | false | Configuration name | Display name of the POS. |
| iface_tax_included | VARCHAR | false | Tax inclusion policy | e.g., 'total', 'subtotal'. |
| customer_display_type | VARCHAR | true | Type of customer display | UI configuration. |
| customer_display_bg_img_name | VARCHAR | true | Background image filename | For customer-facing screens. |
| proxy_ip | VARCHAR(45) | true | IP address of the POSBox/IoT Box | Used for hardware communication. |
| uuid | VARCHAR | true | Unique identifier | Used for synchronization. |
| picking_policy | VARCHAR | false | Stock picking policy | e.g., 'direct', 'one'. |
| receipt_header | TEXT | true | Custom header text for receipts | HTML/Text content. |
| receipt_footer | TEXT | true | Custom footer text for receipts | HTML/Text content. |
| is_order_printer | BOOLEAN | true | Enable order printing | Kitchen/Bar printer flag. |
| iface_cashdrawer | BOOLEAN | true | Enable cash drawer | Hardware flag. |
| iface_electronic_scale | BOOLEAN | true | Enable electronic scale | Hardware flag. |
| iface_print_via_proxy | BOOLEAN | true | Print via IoT Box | Hardware flag. |
| iface_scan_via_proxy | BOOLEAN | true | Scan via IoT Box | Hardware flag. |
| iface_big_scrollbars | BOOLEAN | true | UI setting: big scrollbars | UI flag. |
| iface_print_auto | BOOLEAN | true | Auto-print receipts | UI flag. |
| iface_print_skip_screen | BOOLEAN | true | Skip print preview screen | UI flag. |
| restrict_price_control | BOOLEAN | true | Restrict manual price changes | Security flag. |
| is_margins_costs_accessible_to_every_user | BOOLEAN | true | Show margins/costs to users | Security flag. |
| set_maximum_difference | BOOLEAN | true | Enable max cash difference | Security flag. |
| basic_receipt | BOOLEAN | true | Use basic receipt format | UI flag. |
| active | BOOLEAN | true | Soft-delete flag | Standard Odoo active flag. |
| iface_tipproduct | BOOLEAN | true | Enable tipping | Feature flag. |
| use_pricelist | BOOLEAN | true | Enable pricelist selection | Feature flag. |
| tax_regime_selection | BOOLEAN | true | Enable tax regime selection | Feature flag. |
| limit_categories | BOOLEAN | true | Limit product categories | UI flag. |
| module_pos_restaurant | BOOLEAN | true | Restaurant mode enabled | Feature flag. |
| module_pos_avatax | BOOLEAN | true | AvaTax integration enabled | Feature flag. |
| module_pos_discount | BOOLEAN | true | Discount module enabled | Feature flag. |
| is_posbox | BOOLEAN | true | Is a POSBox/IoT Box | Hardware flag. |
| is_header_or_footer | BOOLEAN | true | Enable custom header/footer | UI flag. |
| module_pos_hr | BOOLEAN | true | HR/Employee module enabled | Feature flag. |
| other_devices | BOOLEAN | true | Enable other hardware devices | Hardware flag. |
| cash_rounding | BOOLEAN | true | Enable cash rounding | Accounting flag. |
| only_round_cash_method | BOOLEAN | true | Round only cash payments | Accounting flag. |
| manual_discount | BOOLEAN | true | Allow manual discounts | Feature flag. |
| ship_later | BOOLEAN | true | Enable ship-later feature | Feature flag. |
| auto_validate_terminal_payment | BOOLEAN | true | Auto-validate payments | Feature flag. |
| show_product_images | BOOLEAN | true | Display product images | UI flag. |
| show_category_images | BOOLEAN | true | Display category images | UI flag. |
| module_pos_sms | BOOLEAN | true | SMS receipt module enabled | Feature flag. |
| is_closing_entry_by_product | BOOLEAN | true | Group closing entries by product | Accounting flag. |
| order_edit_tracking | BOOLEAN | true | Track order edits | Audit flag. |
| orderlines_sequence_in_cart_by_category | BOOLEAN | true | Sort order lines by category | UI flag. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| amount_authorized_diff | DOUBLE PRECISION | true | Max authorized cash difference | Currency units. |
| epson_printer_ip | VARCHAR | true | Epson printer IP address | Hardware specific. |
| sms_receipt_template_id | INTEGER | true | SMS template ID | Links to sms.template. |
| crm_team_id | INTEGER | true | Associated CRM team | Links to crm.team. |
| down_payment_product_id | INTEGER | true | Product for down payments | Links to product.product. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
    - `warehouse_id` → `stock_warehouse.id` (Links POS to specific inventory location)
    - `journal_id` → `account_journal.id` (Links POS to accounting ledger)
- **Natural keys (inferred):** 
    - `name` (Usually unique within a company context)
    - `uuid` (Global unique identifier for synchronization)

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are typically stored in UTC in Odoo databases.
- **Soft Deletes:** The `active` column is a standard Odoo soft-delete flag; records with `active = false` should generally be excluded from operational reports.
- **Sensitivity:** `access_token` should be treated as a sensitive credential and masked in logs or downstream analytics.
- **Data Pattern:** This is a raw staging table; boolean flags are often used to toggle Odoo modules, meaning their presence might depend on whether specific Odoo apps are installed.