using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data.Models
{
    public class Monster
    {
        public string Name { get; set; }
        public int BeseDamage { get; set; }
        public int BaseDefense { get; set; }
        public int Health { get; set; }
        public string HeroName { get; set; }
        public int Type { get; set; }

    }
}
