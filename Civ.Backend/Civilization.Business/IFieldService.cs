using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface IFieldService
    {
        void FieldAdd(List<CellDTO> cells);
        void FieldUpdate(List<CellDTO> cells);
        void FieldDelete(List<CellDTO> cells);
        List<CellDTO> FieldGet();
    }
}