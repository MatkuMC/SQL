SELECT TeamID, TeamName FROM Teams

CREATE TEMPORARY TABLE tGoalsConceded (SELECT M.MatchID, 
SUM( G.OpenPlay ) AS TotalOpen, 
SUM( G.Corners ) AS TotalCorner, 
SUM( G.Throws ) AS TotalThrows, 
SUM( G.DFKicks ) AS TotalKicks , 
SUM( G.SetPlay ) AS TotalSetPlay, 
SUM( G.Penalties ) AS TotalPen,
(SUM( G.OpenPlay ) + SUM( G.Corners ) + SUM( G.Throws ) + SUM( G.DFKicks ) + SUM( G.SetPlay ) + SUM( G.Penalties )) AS Total
FROM Matches AS M
INNER JOIN Teams AS T 
ON ( T.TeamID = M.TeamID1 OR T.TeamID = M.TeamID2 )
AND T.TeamID = 100
INNER JOIN PlayerMatches AS PM 
ON PM.MatchID = M.MatchID
INNER JOIN Players AS P 
ON P.PlayerID = PM.PlayerID
AND P.TeamID != T.TeamID
INNER JOIN Goals AS G 
ON G.ID = PM.ID
GROUP BY M.MatchID);

CREATE TEMPORARY TABLE tGoalsScored (SELECT M.MatchID, 
SUM( G.OpenPlay ) AS TotalOpen, 
SUM( G.Corners ) AS TotalCorner, 
SUM( G.Throws ) AS TotalThrows, 
SUM( G.DFKicks ) AS TotalKicks , 
SUM( G.SetPlay ) AS TotalSetPlay, 
SUM( G.Penalties ) AS TotalPen,
(SUM( G.OpenPlay ) + SUM( G.Corners ) + SUM( G.Throws ) + SUM( G.DFKicks ) + SUM( G.SetPlay ) + SUM( G.Penalties )) AS Total
FROM Matches AS M
INNER JOIN Teams AS T 
ON ( T.TeamID = M.TeamID1 OR T.TeamID = M.TeamID2 )
AND T.TeamID = 100
INNER JOIN PlayerMatches AS PM 
ON PM.MatchID = M.MatchID
INNER JOIN Players AS P 
ON P.PlayerID = PM.PlayerID
AND P.TeamID = T.TeamID
INNER JOIN Goals AS G 
ON G.ID = PM.ID
GROUP BY M.MatchID);

SELECT M.MatchID, 
T1.TeamName as Team1, 
T2.TeamName as Team2, 
tGC.Total as TotalConceded, 
tGS.Total as TotalScored,
CASE WHEN(tGS.Total>tGC.Total) THEN 3 
	 WHEN(tGS.Total=tGC.Total) THEN 1
	 WHEN(tGS.Total<tGC.Total) THEN 0 END as Points
FROM Matches as M
INNER JOIN tGoalsConceded as tGC 
ON tGC.MatchID = M.MatchID
INNER JOIN tGoalsScored as tGS
ON tGS.MatchID = M.MatchID
INNER JOIN Teams as T1
ON T1.TeamID = M.TeamID1
INNER JOIN Teams as T2
ON T2.TeamID = M.TeamID2