with players as (
    -- 引用清洗好的球员数据
    select * from {{ ref('stg_nba_players') }}
),

games as (
    -- 引用清洗好的比赛数据
    select * from {{ ref('stg_nba_games') }}
),

joined_data as (
    select
        players.player_id,
        players.player_name,
        players.team_name,
        games.game_id,
        games.game_date,
        -- 把比赛双方拼成一个字符串，方便看
        games.home_team_name || ' vs ' || games.away_team_name as match_up,
        games.game_result,
        
        -- 核心业务逻辑：计算胜负
        case
            when players.team_name = games.home_team_name and games.game_result = 'Home Win' then 1
            when players.team_name = games.away_team_name and games.game_result = 'Away Win' then 1
            else 0
        end as is_win

    from players
    -- Inner Join: 只有当球员的球队出现在比赛表中时，才保留数据
    inner join games 
        on players.team_name = games.home_team_name 
        or players.team_name = games.away_team_name
)

select * from joined_data