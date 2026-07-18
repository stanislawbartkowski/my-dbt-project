-- Thin passthrough over the raw.customers source table
select * from {{ source('raw', 'customers') }}
