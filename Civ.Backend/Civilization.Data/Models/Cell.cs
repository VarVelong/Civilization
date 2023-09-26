﻿namespace Civilization.Data.Models
{
    public class Cell
    {
        public int X { get; set; }
        public int Y { get; set; }
        public bool? Man { get; set; }
        public int? SaveId { get; set; }
        public City City { get; set; }
    }
}
