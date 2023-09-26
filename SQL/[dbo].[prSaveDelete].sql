USE [Civilization]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prSaveDelete]

@id int
AS

BEGIN TRAN
	DELETE FROM Civilization.dbo.[Save]
	WHERE id = @id;

COMMIT