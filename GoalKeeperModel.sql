SELECT P.PlayerID, P.Surname, P.Forename, P.TeamID, 
SUM( GC.Total ) AS TotalConceded, 
SUM( GC.InsideBox ) AS TotalConcededIB, 
SUM( GC.OutsideBox ) AS TotalConcededOB
FROM Players AS P
INNER JOIN PlayerMatches AS PM ON PM.PlayerID = P.PlayerID
INNER JOIN GoalsConceded AS GC ON GC.ID = PM.ID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
INNER JOIN Positions AS PO ON PO.PositionID = MI.PositionID
AND PO.Position = 'GK'
GROUP BY P.PlayerID
HAVING SUM( GC.Total ) >10
ORDER BY TotalConceded DESC

SELECT T.TeamID, T.TeamName, 
SUM( IB.ShotsOn ) AS TotalShotsOnIB,
SUM( OB.ShotsOn ) AS TotalShotsOnOB
FROM Matches AS M
INNER JOIN Teams AS T ON ( T.TeamID = M.TeamID1
OR T.TeamID = M.TeamID2 )
INNER JOIN PlayerMatches AS PM ON PM.MatchID = M.MatchID
INNER JOIN Players AS P ON P.PlayerID = PM.PlayerID
AND P.TeamID != T.TeamID
INNER JOIN InsideBox AS IB ON IB.ID = PM.ID
INNER JOIN OutsideBox AS OB ON OB.ID = PM.ID
WHERE M.MatchID
IN (

SELECT M.MatchID
FROM Matches AS M
INNER JOIN PlayerMatches AS PM ON PM.MatchID = M.MatchID
INNER JOIN MatchInfo AS MI ON MI.ID = PM.ID
AND MI.Starts =1
INNER JOIN Players AS P ON P.PlayerID = PM.PlayerID
AND P.PlayerID =$values[0]
)
AND T.TeamID =$values[1]
GROUP BY T.TeamID

SELECT T.TeamID, T.TeamName, SUM( IB.ShotsOn ) AS TotalShotsOnIB, SUM( OB.ShotsOn ) AS TotalShotsOnOB
FROM Matches AS M
INNER JOIN Teams AS T ON ( T.TeamID = M.TeamID1
OR T.TeamID = M.TeamID2 )
INNER JOIN PlayerMatches AS PM ON PM.MatchID = M.MatchID
INNER JOIN Players AS P ON P.PlayerID = PM.PlayerID
AND P.TeamID != T.TeamID
INNER JOIN InsideBox AS IB ON IB.ID = PM.ID
INNER JOIN OutsideBox AS OB ON OB.ID = PM.ID
GROUP BY T.TeamID
ORDER BY T.TeamName ASC

SELECT T.TeamID, T.TeamName, SUM( IB.Goals ) AS TotalConcededIB, SUM( OB.Goals ) AS TotalConcededOB
FROM Matches AS M
INNER JOIN Teams AS T ON ( T.TeamID = M.TeamID1
OR T.TeamID = M.TeamID2 )
INNER JOIN PlayerMatches AS PM ON PM.MatchID = M.MatchID
INNER JOIN Players AS P ON P.PlayerID = PM.PlayerID
AND P.TeamID != T.TeamID
INNER JOIN InsideBox AS IB ON IB.ID = PM.ID
INNER JOIN OutsideBox AS OB ON OB.ID = PM.ID
GROUP BY T.TeamID
ORDER BY T.TeamName ASC