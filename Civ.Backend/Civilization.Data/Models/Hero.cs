using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Civilization.Data.Models
{
    public class Hero
    {
        public string Name { get; set; }
        public int BaseDamage   { get; set; }
        public int BaseDefense { get; set; }
        public int Health { get; set; }
        public int Mana { get; set; }
        public int Strength { get; set; }
        public int Endurance { get; set; }
        public int Accuracy     { get; set; }
        public int Speed { get; set; }
        public int Inteligance { get; set; }
        public int type { get; set; }
    }
}
