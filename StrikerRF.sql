SELECT P.PlayerID, P.Surname, P.Forename, SUM( RF.Goals ) as TotalRFGoals, 
SUM( RF.ShotsOn) as TotalRFOn,
SUM( RF.ShotsOff) as TotalRFOff
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
INNER JOIN Positions AS PO ON PO.PositionID = MI.PositionID
AND PO.Position = 'Attacker'
INNER JOIN RightFoot AS RF ON RF.ID = PM.ID
GROUP BY P.PlayerID
ORDER BY TotalRFGoals DESC,TotalRFOn DESC,TotalRFOff DESC
LIMIT 0 , 10