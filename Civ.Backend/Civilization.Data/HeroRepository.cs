using Civilization.Data.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data
{
    public class HeroRepository : BaseRepository, IHeroRepository
    {
        public Hero HeroSelect(Hero Hero)
        {
            string sql = "Exec dbo.prHeroSelect @Name, @BaseDamage, @BaseDefense, @Health, @Mana, @Strength, @Endurance, @Accuracy, @Speed, @Inteligance, @Type";

            using (var conn = new SqlConnection(databaseConnection))
            {
                //return
            }
        }
    }
}
