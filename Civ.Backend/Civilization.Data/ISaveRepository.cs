using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface ISaveRepository
    {
        Save SaveAdd(Save save);
        void SaveDelete(int id);
        IEnumerable<Save> SaveGet();
        Save SaveUpdate(Save save);
    }
}