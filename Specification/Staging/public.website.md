# website

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `sequence`) and the specific grouping of social media and configuration fields are characteristic of Odoo's `website` model.

## Functional process 
This table supports the Website Builder and Content Management System (CMS) module within the ERP. It manages the configuration, integration settings, and social media links for multiple web properties hosted or managed by the platform, linking them to specific companies and users.

## Description
One row in this table represents a single website instance configured within the Odoo environment. It acts as a raw landing copy of the `website` model, capturing the site's identity, third-party service integrations (analytics, maps, CDNs), and administrative settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order | Used for sorting websites in the UI. |
| company_id | INTEGER | false | Foreign key to company | Links the website to a specific legal entity. |
| default_lang_id | INTEGER | false | Default language ID | Reference to the primary language configuration. |
| user_id | INTEGER | false | Responsible user ID | The primary user/owner of the website. |
| theme_id | INTEGER | true | Theme ID | Reference to the active website theme. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Website name | Human-readable name of the site. |
| domain | VARCHAR | true | Domain name | The URL domain associated with the site. |
| social_twitter | VARCHAR | true | Twitter URL | Social media profile link. |
| social_facebook | VARCHAR | true | Facebook URL | Social media profile link. |
| social_github | VARCHAR | true | GitHub URL | Social media profile link. |
| social_linkedin | VARCHAR | true | LinkedIn URL | Social media profile link. |
| social_youtube | VARCHAR | true | YouTube URL | Social media profile link. |
| social_instagram | VARCHAR | true | Instagram URL | Social media profile link. |
| social_tiktok | VARCHAR | true | TikTok URL | Social media profile link. |
| google_analytics_key | VARCHAR | true | GA Tracking ID | Integration key for Google Analytics. |
| google_search_console | VARCHAR | true | Search Console ID | Integration key for Google Search Console. |
| google_maps_api_key | VARCHAR | true | Maps API Key | API key for Google Maps integration. |
| plausible_shared_key | VARCHAR | true | Plausible Key | Shared key for Plausible Analytics. |
| plausible_site | VARCHAR | true | Plausible Site ID | Site identifier for Plausible Analytics. |
| cdn_url | VARCHAR | true | CDN base URL | URL for the Content Delivery Network. |
| homepage_url | VARCHAR | true | Homepage path | Relative or absolute path to the homepage. |
| auth_signup_uninvited | VARCHAR | true | Signup policy | Configuration for public user registration. |
| custom_blocked_third_party_domains | TEXT | true | Blocked domains list | List of domains to block for privacy. |
| cdn_filters | TEXT | true | CDN filter rules | Regex or patterns for CDN asset filtering. |
| custom_code_head | TEXT | true | Custom HTML (Head) | Injected code for the `<head>` section. |
| custom_code_footer | TEXT | true | Custom HTML (Footer) | Injected code for the `<footer>` section. |
| robots_txt | TEXT | true | robots.txt content | Custom content for the robots.txt file. |
| auto_redirect_lang | BOOLEAN | true | Auto-redirect flag | Redirect users based on browser language. |
| cookies_bar | BOOLEAN | true | Cookie bar enabled | Flag to show/hide the cookie consent banner. |
| configurator_done | BOOLEAN | true | Configurator status | Indicates if the website wizard is complete. |
| block_third_party_domains | BOOLEAN | true | Block third-party flag | Global toggle for third-party domain blocking. |
| has_social_default_image | BOOLEAN | true | Social image flag | Indicates if a default social sharing image exists. |
| cdn_activated | BOOLEAN | true | CDN enabled | Flag to enable/disable CDN usage. |
| specific_user_account | BOOLEAN | true | User account mode | Flag for specific user account requirements. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| crm_default_team_id | INTEGER | true | Default CRM team | Default sales team for leads from this site. |
| crm_default_user_id | INTEGER | true | Default CRM user | Default salesperson for leads from this site. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `default_lang_id` → `res_lang.id` (Standard Odoo language reference).
    - `user_id` → `res_users.id` (Standard Odoo user reference).
    - `theme_id` → `ir_module_module.id` (Likely reference to theme module).
- **Natural keys (inferred):**
    - `domain` (Assuming one website per domain in the system).

## Caveats for downstream consumers

- **Sensitive Data:** Contains API keys (`google_maps_api_key`, `plausible_shared_key`) and potentially custom HTML/JS code which may contain sensitive logic. Mask these columns in non-production environments.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually hard-deleted unless a specific `active` column (not present here) is used.
- **Data Type:** `VARCHAR` lengths are not specified in the source; assume standard Odoo lengths (often 255) but verify if truncating data.