using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface ISaveService
    {
        IEnumerable<SaveDto> GetList();
        SaveDto FieldAdd(List<CellDto> cells, SaveTypeDto saveType);
        SaveDto FieldUpdate(List<CellDto> cells, SaveTypeDto saveType, int? saveSlotNumber);
    }
}