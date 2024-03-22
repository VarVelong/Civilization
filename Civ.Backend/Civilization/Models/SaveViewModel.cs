namespace Civilization.Models
{
    public class SaveViewModel
    {
        public int Id { get; set; }
        public DateTime SavedOn { get; set; }
        public SaveType SaveType { get; set; }
    }
}
