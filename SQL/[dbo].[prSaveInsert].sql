USE [Civilization]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prSaveInsert]

@Id int,
@SavedOn datetime2
as

BEGIN TRAN
	INSERT INTO Civilization.dbo.Cell (Id, SavedOn)
	VALUES (@Id, @SavedOn);

COMMIT