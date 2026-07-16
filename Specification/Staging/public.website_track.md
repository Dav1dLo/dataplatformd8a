# website_track

## Source system
The source system is likely a web analytics or clickstream tracking service, such as Segment, Google Analytics (via BigQuery export), or a custom-built event logging system integrated into the application's frontend. The presence of `visitor_id` and `page_id` suggests a relational tracking schema designed to capture user navigation patterns.

## Functional process 
This table supports the web analytics and user behavior tracking pipeline. It records individual page views or navigation events, allowing for the reconstruction of user journeys, calculation of session duration, and analysis of traffic patterns across the website.

## Description
One row in this table represents a single page view or tracking event initiated by a visitor. It serves as a raw landed copy of clickstream data, capturing the temporal and navigational context of a user's interaction with the site.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_track_id_seq`. |
| visitor_id | INTEGER | false | Unique identifier for the visitor | Likely links to a `visitors` dimension table. |
| page_id | INTEGER | true | Unique identifier for the page visited | Nullable if the event is a non-page interaction (e.g., click). |
| url | TEXT | true | The full URL of the page visited | Variable length; may contain query parameters. |
| visit_datetime | TIMESTAMP | false | Timestamp of the event | Assumed to be in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `visitor_id` → `visitors.id` (Guess: standard naming convention for user tracking).
    - `page_id` → `pages.id` (Guess: standard naming convention for content tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `url` column may contain PII in query parameters (e.g., email addresses or session tokens); consider masking if necessary.
- **Timezone:** Timestamps are assumed to be in UTC; verify against the application configuration.
- **Data Integrity:** `page_id` is nullable, which may indicate events that do not map to a specific page (e.g., tracking clicks on external links or modal interactions).
- **Grain:** This is a high-volume event table; queries should be filtered by `visit_datetime` to avoid full table scans.