-- Thin passthrough over the raw.orders source table
select * from {{ source('raw', 'orders') }}
