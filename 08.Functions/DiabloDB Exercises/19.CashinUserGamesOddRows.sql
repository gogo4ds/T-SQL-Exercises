CREATE FUNCTION ufn_CashInUsersGames (@gameName varchar(50))
RETURNS @cash TABLE (
	SumCash MONEY
)
AS
BEGIN
	INSERT INTO @cash (SumCash)
	SELECT SUM(orders.Cash) AS SumCash FROM
	(SELECT ug.Cash
		,g.Name
		,ROW_NUMBER() OVER (ORDER BY ug.Cash DESC) AS rows
	FROM UsersGames AS ug
	INNER JOIN Games AS g
	ON g.Id = ug.GameId AND g.Name = @gameName) AS orders
	WHERE CAST(orders.rows AS INT) % 2 != 0

	RETURN;
END

SELECT * FROM ufn_CashInUsersGames ('Ming fern')