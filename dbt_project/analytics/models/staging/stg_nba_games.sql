with source as (

    select * from {{ source('nba_raw', 'nba_games') }}

),

renamed as (

    select
        game_id,
        game_date,
        home_team as home_team_name, -- 改个名，更清晰
        away_team as away_team_name,
        home_score,
        away_score,
        season,
        
        -- 计算一个简单的逻辑：主场队赢了吗？
        case 
            when home_score > away_score then 'Home Win'
            else 'Away Win'
        end as game_result

    from source

)

select * from renamed