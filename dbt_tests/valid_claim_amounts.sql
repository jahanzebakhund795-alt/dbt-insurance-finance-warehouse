select * from {{ ref('fact_claim') }}
where incurred_cents<0 or paid_cents<0 or paid_cents>incurred_cents
   or (status='denied' and paid_cents<>0)
