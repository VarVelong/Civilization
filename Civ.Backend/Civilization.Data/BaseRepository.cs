﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data
{
    public class BaseRepository
    {
        private string connectionStringLAP = @"Data Source=VARVELONGLAPTOP\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        private string connectionStringPC = @"Data Source=DESKTOP-2HIVFFU\SQLEXPRESS;Initial Catalog=Civilization;Integrated Security=True";
        protected string databaseConnection;
        public BaseRepository() {
            //switching database connections between PC and Laptop
            databaseConnection = connectionStringLAP;
        }
    }
}
