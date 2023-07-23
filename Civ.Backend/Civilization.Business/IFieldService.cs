using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface IFieldService
    {
        void FieldAdd(List<CellDto> cells);
        void FieldUpdate(List<CellDto> cells);
        void FieldDelete(List<CellDto> cells);
        List<CellDto> FieldGet(int saveId);
    }
}