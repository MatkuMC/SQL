SELECT P.PlayerID, P.Surname, P.Forename, SUM( AOT.OpenPlay ) AS TotalAOT, SUM( AFT.OpenPlay ) AS TotalAFT, (
(
SUM( AOT.OpenPlay ) / ( SUM( AOT.OpenPlay ) + SUM( AFT.OpenPlay ) )
) *100
) AS PercentageAOT
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN AttemptsOnTarget AS AOT ON AOT.ID = PM.ID
INNER JOIN AttemptsOffTarget AS AFT ON AFT.ID = PM.ID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
INNER JOIN Positions AS PO ON PO.PositionID = MI.PositionID
AND PO.Position = 'Attacker'
GROUP BY P.PlayerID
HAVING SUM( AOT.OpenPlay ) >30
ORDER BY TotalAOT DESC
LIMIT 0 , 30