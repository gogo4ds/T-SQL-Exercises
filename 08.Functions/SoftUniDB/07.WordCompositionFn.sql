CREATE FUNCTION ufn_IsWordComprised (@setOfLetters varchar(255), @word varchar(255))
RETURNS BIT
AS
BEGIN
	DECLARE @result BIT = 1;
	DECLARE @position INT = 1;
		
	WHILE(@position <= LEN(@word))
	BEGIN
		IF(CHARINDEX(SUBSTRING(@word, @position, 1), @setOfLetters , 1) IN (0, NULL))
		 BEGIN
			SET @result = 0;
			RETURN @result
		 END
		SET @position += 1;
	END

	RETURN @result
END

SELECT 'oistmiahf' AS SetOfLetters
	,'Sofiaz' AS Word
	,dbo.ufn_IsWordComprised('oistmiahf', 'Sofiaz') AS Result