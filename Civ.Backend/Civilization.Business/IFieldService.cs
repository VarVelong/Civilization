using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface IFieldService
    {
        void FieldDelete(List<CellDto> cells);
        List<CellDto> FieldGet(int saveId);
    }
}