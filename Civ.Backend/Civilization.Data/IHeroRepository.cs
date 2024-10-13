using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface IHeroRepository
    {
        Hero HeroSelect(Hero Hero);
    }
}