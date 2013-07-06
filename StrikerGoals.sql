SELECT P.PlayerID, P.Surname, P.Forename, SUM( G.OpenPlay ) as TotalOPGoals
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN Goals AS G ON G.ID = PM.ID
GROUP BY P.PlayerID
ORDER BY TotalOPGoals DESC
LIMIT 0 , 30