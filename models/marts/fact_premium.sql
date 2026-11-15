select p.invoice_id,d.policy_key,p.policy_id,p.billed_date,p.written_premium_cents
from {{ ref('stg_premiums') }} p left join {{ ref('dim_policy') }} d using(policy_id)
