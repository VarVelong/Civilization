using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface IFieldRepository
    {
        void FieldAdd(Cell cell);
        void FieldUpdate(Cell cell);
        void FieldDelete(int x, int y);
        IEnumerable<Cell> FieldGet();
    }
}