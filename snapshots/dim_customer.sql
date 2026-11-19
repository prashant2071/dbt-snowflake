{% snapshot dim_customer %}

{#
    SCD Type 2 history of customers -> BANKING_DATA.GOLD.DIM_CUSTOMER

    strategy = 'check': a new version is recorded only when one of the
    check_cols changes. created_date is NOT in the list, because stg_customer
    sets it to CURRENT_TIMESTAMP() on every run and would create a fake
    new version of every customer each time.

    dbt adds: dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to
    (dbt_valid_to IS NULL = current version).
#}

{{ config(
    unique_key    = 'cust_id',
    strategy      = 'check',
    check_cols    = [
        'name', 'address', 'phone_number', 'postal_code', 'country', 'email',
        'father_name', 'mother_name', 'occupation', 'education', 'nationality'
    ],
    invalidate_hard_deletes = true
) }}

WITH src AS (
    SELECT * FROM {{ ref('stg_customer') }}
)

SELECT
    cust_id,
    name,
    address,
    phone_number,
    postal_code,
    country,
    email,
    father_name,
    mother_name,
    occupation,
    education,
    nationality,
    created_date
FROM src

{% endsnapshot %}
