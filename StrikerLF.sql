SELECT P.PlayerID, P.Surname, P.Forename, SUM( LF.Goals ) as TotalLFGoals, 
SUM( LF.ShotsOn) as TotalLFOn,
SUM( LF.ShotsOff) as TotalLFOff
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
INNER JOIN Positions AS PO ON PO.PositionID = MI.PositionID
AND PO.Position = 'Attacker'
INNER JOIN LeftFoot AS LF ON LF.ID = PM.ID
GROUP BY P.PlayerID
ORDER BY TotalLFGoals DESC,TotalLFOn DESC,TotalLFOff DESC
LIMIT 0 , 10