using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface ISaveService
    {
        IEnumerable<SaveDto> GetList();
    }
}