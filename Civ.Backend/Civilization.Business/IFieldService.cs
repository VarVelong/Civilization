using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface IFieldService
    {
        void FieldAdd(List<CellDTO> cells);
    }
}