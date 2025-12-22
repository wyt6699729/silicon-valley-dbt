with source as (

    select * from {{ source('tpch', 'raw_customers') }}

),

renamed as (

    select
        c_custkey as customer_id,
        c_name as customer_name,
        c_address as address,
        c_nationkey as nation_id,
        c_phone as phone_number,
        c_mktsegment as market_segment,
        -- 考点：数据类型转换
        c_acctbal::float as account_balance
        
    from source

)

select * from renamed