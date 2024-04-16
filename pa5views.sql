CREATE VIEW latest_match_standing AS
SELECT st.match_day_id,
       t.team_name,
       st.points,
       st.won,
       st.drawn,
       st.lost,
       st.goals_for,
       st.goals_against
FROM standings st
         JOIN teams t ON st.team_id = t.id
WHERE match_day_id = (
    SELECT md.id
    FROM match_days md
             JOIN seasons s ON md.league_id = s.id
    WHERE s.name = '2023/2024'
    ORDER BY md.day_number DESC
        LIMIT 1);

SELECT * FROM latest_match_standing;