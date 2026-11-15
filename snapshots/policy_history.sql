{% snapshot policy_history %}
{{ config(target_schema='snapshots',unique_key='policy_id',strategy='check',check_cols=['region']) }}
select * from {{ ref('stg_policies') }}
{% endsnapshot %}
