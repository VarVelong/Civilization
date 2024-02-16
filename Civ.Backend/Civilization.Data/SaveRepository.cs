using Civilization.Data.Models;
using Dapper;
using System.Data.SqlClient;

namespace Civilization.Data
{
    public class SaveRepository : ISaveRepository
    {
        private string connectionString;
        public SaveRepository()
        {
            connectionString = @"Data Source=VarVelongLaptop\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        }

        public Save SaveAdd(Save save)
        {
            string sql = "Exec dbo.prSaveInsert @Id, @SavedOn";

            using (var conn = new SqlConnection(connectionString))
            {
                return conn.QueryFirstOrDefault<Save>(sql, save);
            }
        }

        public Save SaveUpdate(Save save)
        {
            string sql = "Exec dbo.prSaveUpdate @Id, @SavedOn";

            using (var conn = new SqlConnection(connectionString))
            {
                return conn.QueryFirstOrDefault<Save>(sql, save);
            }
        }

        public void SaveDelete(int id)
        {
            string sql = "Exec dbo.prSaveDelete @id";

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Execute(sql, new { id });
            }
        }

        public IEnumerable<Save> SaveGet()
        {
            string sql = "Exec dbo.prSaveSelect";

            using (var conn = new SqlConnection(connectionString))
            {
                return conn.Query<Save>(sql);
            }
        }
    }
}