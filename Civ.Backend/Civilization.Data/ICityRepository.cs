using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface ICityRepository
    {
        City CityUpdate(City city);
    }
}