with games as (

    -- 引用我们要用的 staging 模型
    select * from {{ ref('stg_nba_games') }}

),

players as (

    select * from {{ ref('stg_nba_players') }}

),

joined as (

    select
        -- 比赛信息
        g.game_id,
        g.game_date,
        g.season,
        g.home_team_name,
        g.home_score,
        
        -- 球员信息 (我们想知道谁在主场打了这场球)
        p.player_id,
        p.player_name,
        p.jersey_number,
        p.position,
        
        -- 衍生指标：LeBron 在主场赢了吗？
        g.game_result

    from games g
    -- 核心逻辑：用 比赛的主队名 去关联 球员的球队名
    join players p on g.home_team_name = p.team_name

)

select * from joined