{{ config(materialized='incremental',unique_key='claim_id',incremental_strategy='delete+insert') }}
select c.*,d.policy_key
from {{ ref('stg_claims') }} c left join {{ ref('dim_policy') }} d using(policy_id)
{% if is_incremental() %}
where c.updated_at >= (select coalesce(max(updated_at),timestamp '1900-01-01') from {{ this }})
{% endif %}
