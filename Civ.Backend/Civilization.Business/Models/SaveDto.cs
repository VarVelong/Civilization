namespace Civilization.Business.Models
{
    public class SaveDto
    {
        public int Id { get; set; }
        public DateTime SavedOn { get; set; }
        
        public SaveTypeDto SaveType { get; set; }
    }
}
