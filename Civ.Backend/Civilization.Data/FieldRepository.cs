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
            connectionString = @"Data Source=LAPTOP-BIR7OQ53\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        }

        public void FieldAdd(Cell cell)
        {
            string sql = "Exec dbo.prCellInsert @X, @Y, @Man";

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Execute(sql, cell);
            }
        }

    }
}