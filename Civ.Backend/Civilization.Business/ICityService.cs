using Civilization.Business.Models;

namespace Civilization.Business
{
    public interface ICityService
    {
        CityDto CityUpdate(CityDto cityViewModel);
    }
}