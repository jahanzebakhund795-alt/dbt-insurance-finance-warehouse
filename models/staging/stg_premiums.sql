select cast(invoice_id as varchar) as invoice_id,cast(policy_id as varchar) as policy_id,
       cast(billed_date as date) as billed_date,cast(amount_cents as bigint) as written_premium_cents
from {{ ref('premiums') }}
