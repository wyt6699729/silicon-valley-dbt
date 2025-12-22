with source as (

    select * from {{ source('tpch', 'raw_orders') }}

),

renamed as (

    select
        o_orderkey as order_id,
        o_custkey as customer_id,
        o_orderstatus as status,
        o_totalprice::float as total_price,
        o_orderdate as order_date,
        
        -- ✅ 修正：字段名应该是 o_orderpriority
        o_orderpriority as priority, 
        
        -- 业务逻辑
        case 
            when o_orderpriority = '1-URGENT' then 'High'
            else 'Normal'
        end as urgency_level
        
    from source

)

select * from renamed