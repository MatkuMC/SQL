DROP PROCEDURE IF EXISTS prcGetKey;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prcGetKey`(IN `matchID` INT(5), IN `playerID` INT(5))
    NO SQL
BEGIN
SELECT PlayerMatches.ID FROM testdb.PlayerMatches 
WHERE PlayerMatches.MatchID = matchID 
AND PlayerMatches.PlayerID = playerID;
END