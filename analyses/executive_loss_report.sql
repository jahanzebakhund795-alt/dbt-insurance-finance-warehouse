select region,sum(written_premium_cents) as written_premium_cents,
       sum(incurred_cents) as incurred_cents,
       sum(incurred_cents)*1.0/nullif(sum(written_premium_cents),0) as weighted_loss_ratio
from {{ ref('mart_policy_loss') }} group by region
