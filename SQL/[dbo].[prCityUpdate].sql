USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellUpdate]    Script Date: 24.03.2024 18:24:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCityUpdate]

@Id int,
@CityHall bit = 0, 
@MagicTower bit = 0,
@Tavern bit = 0,
@Market bit = 0,
@UnknownOne bit = 0,
@UnknownTwo bit = 0,
@BarracksOne bit = 0,
@BarracksTwo bit = 0,
@BarracksThree bit = 0,
@BarracksFour bit = 0,
@BarracksFive bit = 0,
@BarracksSix bit = 0
as

BEGIN TRAN

	UPDATE dbo.City 
	SET CityHall = @CityHall,
		MagicTower = @MagicTower,
		Tavern = @Tavern,
		Market = @Market, 
		UnknownOne	= @UnknownOne,
		UnknownTwo	= @UnknownTwo,
		BarracksOne = @BarracksOne,
		BarracksTwo = @BarracksTwo,
		BarracksThree = @BarracksThree,
		BarracksFour = @BarracksFour,
		BarracksFive = @BarracksFive,
		BarracksSix	= @BarracksSix

	WHERE Id = @Id

COMMIT