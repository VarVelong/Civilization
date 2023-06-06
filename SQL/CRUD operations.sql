INSERT INTO Cell (X, Y, Man)
VALUES (1, 5, 1);

UPDATE Cell
SET X=10, Y=11
WHERE Man = 1;

DELETE FROM Cell WHERE Man = 1;

SELECT TOP (1000) [X]
      ,[Y]
      ,[Man]
  FROM [Civilization].[dbo].[Cell];