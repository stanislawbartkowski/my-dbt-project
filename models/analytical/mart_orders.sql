with orders as (
    select * from {{ ref('stg_orders') }}
)

select
    customer_id,
    count(order_id) as number_of_orders,
    sum(amount) as total_amount,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date
from orders
group by customer_id
