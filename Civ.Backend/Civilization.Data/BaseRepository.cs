using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data
{
    public class BaseRepository
    {
        private string connectionStringLAP = @"Data Source=VARVELONGLAPTOP\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        private string connectionStringPC = @"Data Source=DESKTOP-7EFJTVO\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        protected string databaseConnection;
        public BaseRepository() {
            //switching database connections between PC and Laptop
            //databaseConnection = @"Data Source=DIGIPC\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";//connectionStringLAP;
            databaseConnection = connectionStringPC;
        }
    }
}
