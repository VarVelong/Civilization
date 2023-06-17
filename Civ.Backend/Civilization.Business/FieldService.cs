using Civilization.Data;
using Civilization.Models;

namespace Civilization.Business
{
    public class FieldService
    {
        private FieldRepository fieldRepository = new FieldRepository();

        public void FieldAdd(List<Cell> cell)
        {
            fieldRepository.FieldAdd(cell); 
        }
    }
}