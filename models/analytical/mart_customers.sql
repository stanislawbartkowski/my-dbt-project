with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('mart_orders') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    coalesce(orders.number_of_orders, 0) as number_of_orders,
    coalesce(orders.total_amount, 0) as lifetime_value,
    orders.first_order_date,
    orders.most_recent_order_date
from customers
left join orders on customers.customer_id = orders.customer_id
