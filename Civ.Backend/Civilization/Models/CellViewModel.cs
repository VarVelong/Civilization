﻿namespace Civilization.Models
{
    public class CellViewModel
    {
        public int X { get; set; }
        public int Y { get; set; }
        public bool? Man { get; set; }
        public int? SaveId { get; set; }
        public CityViewModel City { get; set; }
    }
}
