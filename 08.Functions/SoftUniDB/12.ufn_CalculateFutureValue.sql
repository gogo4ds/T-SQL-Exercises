CREATE FUNCTION ufn_CalculateFutureValue (@sum MONEY, @rate FLOAT, @years INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @futureValue MONEY;

	SET @futureValue = @sum * (POWER((1 + @rate), @years))

	RETURN @futureValue;
END

SELECT dbo.ufn_CalculateFutureValue (1000, 0.1, 5) AS Output