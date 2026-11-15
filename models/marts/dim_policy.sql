select md5(policy_id) as policy_key,policy_id,region,inception_date
from {{ ref('stg_policies') }}
