using Civilization.Data.Models;

namespace Civilization.Data
{
    public interface IMonsterRepository
    {
        Monster MonsterSelect(Monster Monster);
    }
}