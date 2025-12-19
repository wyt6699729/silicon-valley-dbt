with source as (

    -- 这里是关键！我们不再写 FROM DBT_DEV.PUBLIC...
    -- 而是引用我们在 yaml 里定义的代号
    select * from {{ source('nba_raw', 'nba_players') }}

),

renamed as (

    select
        -- 这里的列名要和 CSV 里的一致
        player_id,
        player_name,
        team_city,
        team_name,
        jersey_number,
        position,
        height_inches,
        weight_lbs,
        draft_year

    from source

)

select * from renamed