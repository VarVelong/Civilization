using Civilization.Data.Models;
using Dapper;
using System.Data.SqlClient;

namespace Civilization.Data
{
    public class CityRepository : BaseRepository, ICityRepository
    {
        public City CityUpdate(City city)
        {
            string sql = "Exec dbo.prCityUpdate @CityHall, @MagicTower, @Tavern, @Market, @UnknownOne, @UnknownTwo, @BarracksOne, @BarracksTwo, @BarracksThree, @BarracksFour, @BarracksFive, @BarracksSix";

            using (var conn = new SqlConnection(databaseConnection))
            {
                return conn.QueryFirstOrDefault<City>(sql, city);
            }
        }
    }
}