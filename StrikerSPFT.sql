SELECT P.PlayerID, P.Surname, P.Forename, 
SUM( SP.FinalThird ) AS TotalSP, 
SUM( SP.Total ) AS Total, 
SUM( USP.FinalThird ) AS TotalUSP, (
(
SUM( SP.FinalThird ) / ( SUM( SP.Total ) )
) *100
) AS PercentageSP, (
(
SUM( USP.FinalThird ) / ( SUM( SP.Total ) )
) *100
) AS PercentageUSP
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN SuccessfulPasses AS SP ON SP.ID = PM.ID
INNER JOIN UnsuccessfulPasses AS USP ON USP.ID = PM.ID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
INNER JOIN Positions AS PO ON PO.PositionID = MI.PositionID
AND PO.Position = 'Attacker'
GROUP BY P.PlayerID
HAVING Total > 400
ORDER BY PercentageSP DESC