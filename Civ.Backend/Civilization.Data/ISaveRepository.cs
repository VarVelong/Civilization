using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface ISaveRepository
    {
        void SaveAdd(Save save);
        void SaveDelete(int id);
        IEnumerable<Save> SaveGet();
        void SaveUpdate(Save save);
    }
}