with raw_orders as (
    select * from {{ ref('raw_orders') }}
)

select
    order_id,
    customer_id,
    order_date,
    status,
    amount
from raw_orders
