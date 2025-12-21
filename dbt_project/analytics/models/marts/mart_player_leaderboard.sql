with player_stats as (
    -- 1. 拿到底层数据
    select * from {{ ref('fct_player_stats') }}
),

agg_stats as (
    -- 2. 开始聚合 (Aggregation)
    select
        player_name,
        team_name,
        
        -- 计算总场次
        count(*) as total_games_played,
        
        -- 计算总胜场 (因为赢了是1，输了是0，sum就是总胜场)
        sum(is_win) as total_wins,
        
        -- 计算胜率 (胜场 / 总场次)，保留2位小数
        round(sum(is_win) / count(*) * 100, 2) as win_percentage

    from player_stats
    
    -- 按球员和球队分组
    group by player_name, team_name
)

-- 3. 按胜场倒序排列，取出真正的 MVP
select * from agg_stats
order by total_wins desc