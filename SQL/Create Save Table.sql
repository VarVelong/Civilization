


CREATE TABLE Civilization.dbo.[Save](
Id int NOT NULL PRIMARY KEY,
[DateTime] DateTime2 NOT NULL);

ALTER TABLE Civilization.[dbo].[Cell]
ADD SaveId int NOT NULL FOREIGN KEY REFERENCES Civilization.dbo.[Save](Id);

ALTER TABLE Civilization.dbo.[cell]
DROP CONSTRAINT [PK_CELL];

ALTER TABLE Civilization.dbo.[cell]
ADD CONSTRAINT [PK_cell] PRIMARY KEY(X,Y,SaveId);

