# payment_provider

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-language message fields (`*_msg`). The structure is typical of Odoo's `payment.provider` model.

## Functional process 
This table supports the payment processing configuration within an e-commerce or invoicing pipeline. It manages the integration settings for various payment gateways (e.g., Stripe, PayPal, Authorize.net), defining how forms are rendered, whether tokenization is enabled, and the specific messaging displayed to customers during different stages of the payment lifecycle.

## Description
One row represents a single configured payment provider instance within the system. It acts as a raw landed copy of the Odoo `payment.provider` model, capturing the operational configuration, UI settings, and localization messages for a specific payment gateway integration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order | Used for sorting providers in the UI. |
| company_id | INTEGER | false | Company identifier | Links to the owning organization. |
| redirect_form_view_id | INTEGER | true | Redirect form view ID | Reference to UI view for redirect-based payments. |
| inline_form_view_id | INTEGER | true | Inline form view ID | Reference to UI view for inline payments. |
| token_inline_form_view_id | INTEGER | true | Token form view ID | Reference to UI view for tokenized payments. |
| express_checkout_form_view_id | INTEGER | true | Express checkout view ID | Reference to UI view for express checkout. |
| color | INTEGER | true | UI color index | Used for visual categorization in the backend. |
| module_id | INTEGER | true | Module identifier | Links to the installed Odoo module. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| code | VARCHAR | false | Provider internal code | Unique string identifier (e.g., 'stripe', 'paypal'). |
| state | VARCHAR | false | Provider status | Status (e.g., 'enabled', 'disabled', 'test'). |
| name | JSONB | false | Provider display name | Multi-language name field. |
| pre_msg | JSONB | true | Pre-payment message | Multi-language message shown before payment. |
| pending_msg | JSONB | true | Pending message | Multi-language message for pending status. |
| auth_msg | JSONB | true | Authorization message | Multi-language message for auth status. |
| done_msg | JSONB | true | Done message | Multi-language message for success status. |
| cancel_msg | JSONB | true | Cancel message | Multi-language message for cancellation. |
| maximum_amount | NUMERIC | true | Max transaction amount | Limit for this provider. |
| is_published | BOOLEAN | true | Published flag | Whether the provider is visible on the website. |
| allow_tokenization | BOOLEAN | true | Tokenization flag | Whether card details can be saved. |
| capture_manually | BOOLEAN | true | Manual capture flag | Whether payments require manual capture. |
| allow_express_checkout | BOOLEAN | true | Express checkout flag | Whether express checkout is enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| so_reference_type | VARCHAR | true | Sales order reference type | Defines how the SO is referenced in the gateway. |
| website_id | INTEGER | true | Website identifier | Links to a specific website if multi-site. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `module_id` → `ir_module_module.id` (Links to the installed module definition).
    - `website_id` → `website.id` (Links to the specific website configuration).
- **Natural keys (inferred):** 
    - `code` (The internal provider code is typically unique per company/website).

## Caveats for downstream consumers

- **JSONB Fields:** The `*_msg` columns contain JSONB data. Downstream consumers will need to extract specific language keys (e.g., `name->>'en_US'`) to use these values in reporting.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes in this table; records are usually updated or deleted directly.
- **Sensitive Data:** While this table contains configuration, ensure that any potential API credentials (if stored in related tables) are not exposed; this table itself appears to be configuration-only.