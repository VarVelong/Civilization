namespace Civilization.Models
{
    public class FieldCreateViewModel
    {
        public List<CellViewModel> Cells { get; set; }
        public SaveType SaveType { get; set; }
        public int SaveSlotNumber { get; set; }
    }
}
