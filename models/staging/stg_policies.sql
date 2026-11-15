select cast(policy_id as varchar) as policy_id,
       upper(trim(region)) as region, cast(inception_date as date) as inception_date
from {{ ref('policies') }}
