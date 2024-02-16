namespace Civilization.Models
{
    public class SaveUpdateViewModel
    {
        public List<CellViewModel> Cells { get; set; }
        public SaveType SaveType { get; set; }
        public int? SaveSlotNumber { get; set; }
    }
}
