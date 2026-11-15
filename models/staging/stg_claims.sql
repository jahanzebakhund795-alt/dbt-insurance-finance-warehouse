select cast(claim_id as varchar) as claim_id,cast(policy_id as varchar) as policy_id,
       cast(reported_date as date) as reported_date,lower(status) as status,
       cast(incurred_cents as bigint) as incurred_cents,cast(paid_cents as bigint) as paid_cents,
       cast(updated_at as timestamp) as updated_at
from {{ ref('claims') }}
