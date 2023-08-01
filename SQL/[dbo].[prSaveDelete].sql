USE [Civilization]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[prSaveDelete]

@id int
as

BEGIN TRAN
	DELETE FROM Civilization.dbo.[Save]
	WHERE id = @id;

COMMIT