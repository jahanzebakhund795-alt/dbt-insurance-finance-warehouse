select * from {{ ref("fact_premium") }} where written_premium_cents<=0
