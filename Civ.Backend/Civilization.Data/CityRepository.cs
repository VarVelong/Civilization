using Civilization.Data.Models;
using Dapper;
using System.Data.SqlClient;

namespace Civilization.Data
{
    public class CityRepository : ICityRepository
    {
        private string connectionString;
        public CityRepository()
        {
            connectionString = @"Data Source=VarVelongLaptop\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        }

        public City CityUpdate(City city)
        {
            string sql = "Exec dbo.prCityUpdate @CityHall, @MagicTower, @Tavern, @Market, @UnknownOne, @UnknownTwo, @BarracksOne, @BarracksTwo, @BarracksThree, @BarracksFour, @BarracksFive, @BarracksSix";

            using (var conn = new SqlConnection(connectionString))
            {
                return conn.QueryFirstOrDefault<City>(sql, city);
            }
        }
    }
}