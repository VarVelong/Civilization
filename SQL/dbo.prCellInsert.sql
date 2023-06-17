USE Civilization
GO
CREATE PROC dbo.prCellInsert

@X int,
@Y int,
@Man bit
as

BEGIN TRAN
	INSERT INTO Civilization.dbo.Cell (X, Y, Man)
	VALUES (@X, @Y, @Man);

COMMIT