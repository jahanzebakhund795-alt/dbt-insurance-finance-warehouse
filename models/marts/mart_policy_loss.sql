with premium as (
    select policy_id,sum(written_premium_cents) as written_premium_cents
    from {{ ref('fact_premium') }} group by policy_id
), claim as (
    select policy_id,count(*) as claim_count,sum(incurred_cents) as incurred_cents,
           sum(paid_cents) as paid_cents from {{ ref('fact_claim') }} group by policy_id
)
select d.policy_id,d.region,coalesce(p.written_premium_cents,0) as written_premium_cents,
       coalesce(c.claim_count,0) as claim_count,coalesce(c.incurred_cents,0) as incurred_cents,
       coalesce(c.paid_cents,0) as paid_cents,
       coalesce(c.incurred_cents,0)*1.0/nullif(p.written_premium_cents,0) as written_premium_loss_ratio
from {{ ref('dim_policy') }} d left join premium p using(policy_id) left join claim c using(policy_id)
