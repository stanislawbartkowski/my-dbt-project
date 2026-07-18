with raw_customers as (
    select * from {{ ref('raw_customers') }}
)

select
    customer_id,
    first_name,
    last_name,
    email,
    created_at
from raw_customers
