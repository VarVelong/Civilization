
USE Civilization

CREATE TABLE dbo.City
(	[Id] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
[Name] [nvarchar](16) NOT NULL)

ALTER TABLE dbo.Cell
ADD [CityId] [int]  NULL
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])

