using Civilization.Data.Models;
using Dapper;
using System.Data.SqlClient;

namespace Civilization.Data
{
    public class FieldRepository : IFieldRepository
    {
        private string connectionString;
        public FieldRepository()
        {
            connectionString = @"Data Source=VarVelongLaptop\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        }

        public void FieldAdd(Cell cell)
        {
            string sql = "Exec dbo.prCellInsert @X, @Y, @Man, @SaveId, @CityName";

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Execute(sql, new { cell.X, cell.Y, cell.Man, cell.SaveId, CityName = cell.City?.Name });
            }
        }

        public void FieldUpdate(Cell cell)
        {
            string sql = "Exec dbo.prCellUpdate @X, @Y, @Man, @SaveId";

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Execute(sql, cell);
            }
        }

        public void FieldDelete(int x, int y)
        {
            string sql = "Exec dbo.prCellDelete @X, @Y";

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Execute(sql, new { x, y });
            }
        }

        public IEnumerable<CellSummary> FieldGet(int saveGameId)
        {
            string sql = "Exec dbo.prCellSelect @saveGameId";

            using (var conn = new SqlConnection(connectionString))
            {
                return conn.Query<CellSummary>(sql, new { saveGameId });
            }
        }
    }
}