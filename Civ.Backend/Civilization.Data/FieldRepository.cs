using Civilization.Data.Models;
using Dapper;
using System.Data.SqlClient;

namespace Civilization.Data
{
    public class FieldRepository : BaseRepository, IFieldRepository
    {
        public void FieldAdd(Cell cell)
        {
            string sql = "Exec dbo.prCellInsert @X, @Y, @Man, @SaveId, @CityName";

            using (var conn = new SqlConnection(databaseConnection))
            {
                conn.Execute(sql, new { cell.X, cell.Y, cell.Man, cell.SaveId, CityName = cell.City?.Name });
            }
        }

        public void FieldUpdate(Cell cell)
        {
            string sql = "Exec dbo.prCellUpdate @X, @Y, @Man, @SaveId, @CityId, @CityName";

            using (var conn = new SqlConnection(databaseConnection))
            {
                conn.Execute(sql, new { cell.X, cell.Y, cell.Man, cell.SaveId, CityId = cell.City?.Id, CityName = cell.City?.Name });
            }
        }

        public void FieldDelete(int x, int y)
        {
            string sql = "Exec dbo.prCellDelete @X, @Y";

            using (var conn = new SqlConnection(databaseConnection))
            {
                conn.Execute(sql, new { x, y });
            }
        }

        public IEnumerable<CellSummary> FieldGet(int saveGameId)
        {
            string sql = "Exec dbo.prCellSelect @saveGameId";

            using (var conn = new SqlConnection(databaseConnection))
            {
                return conn.Query<CellSummary>(sql, new { saveGameId });
            }
        }
    }
}