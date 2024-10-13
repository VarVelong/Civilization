using Civilization.Data.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data
{
    public class MonsterRepository : BaseRepository, IMonsterRepository
    {
        public Monster MonsterSelect(Monster Monster)
        {
            string sql = "Exec dbo.prMonsterSelect @Name, @BaseDamage, @BaseDefense, @Health, @HeroName, @Type";

            using (var conn = new SqlConnection(databaseConnection))
            {
                //return
            }
        }
    }
}