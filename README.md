# my_dbt_project

A dbt project targeting Postgres, organized into raw, staging, and analytical layers.

## Project layout

```
models/
  raw/          Views over source tables (raw_customers, raw_orders)
  staging/      Cleaned/renamed staging views (stg_customers, stg_orders)
  analytical/   Materialized tables for downstream use (mart_customers, mart_orders)
seeds/          CSV seed data (customers, orders)
macros/         Custom macros (e.g. schema name generation)
profiles.yml    Postgres connection profile (reads credentials from env vars)
```

## Prerequisites

- Python 3.12+
- A running Postgres instance

## Setup

1. Create and activate a virtual environment, then install dbt:

   ```bash
   python3 -m venv .venv
   .venv/bin/pip install dbt-postgres
   ```

2. Copy the example env file and fill in your Postgres connection details:

   ```bash
   cp .env.example .env
   ```

   ```
   DBT_POSTGRES_HOST=localhost
   DBT_POSTGRES_PORT=5432
   DBT_POSTGRES_USER=
   DBT_POSTGRES_PASSWORD=
   DBT_POSTGRES_DBNAME=
   DBT_POSTGRES_SCHEMA=public
   ```

   Load the env vars into your shell before running dbt, e.g.:

   ```bash
   export $(cat .env | xargs)
   ```

3. Verify the connection:

   ```bash
   .venv/bin/dbt debug
   ```

## Common commands

```bash
source .venv/bin/activate
source .env

dbt debug   # test connection
dbt seed    # load CSV seeds (customers, orders)
dbt run     # build all models
dbt test    # run tests
```
Run them all
```bash
dbt build
```

Models are materialized as:
- `raw` and `staging` → views
- `analytical` → tables

Each layer is written to its own schema (`raw`, `staging`, `analytics`) as configured in [dbt_project.yml](dbt_project.yml).

## Useful commands

```bash
dbt run --select raw_orders   # build raw_orders model 

dbt show --select raw_orders  # execute select query on model raw_order without running any updates
dbt show --inline "select * from {{ ref('stg_customers') }} where customer_id = 5"
```

## Create Postgresql user for testing
```sql
create user dbt with password 'secret';
create database marketdata;
alter database marketdata owner to dbt;
```
