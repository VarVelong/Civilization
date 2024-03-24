using Civilization.Data;
using Civilization.Business.Models;
using AutoMapper;
using Civilization.Data.Models;

namespace Civilization.Business
{
    public class CityService : ICityService
    {
        private ICityRepository cityRepository;
        private IMapper mapper;

        public CityService(ICityRepository cityRepository, IMapper mapper)
        {
            this.cityRepository = cityRepository;
            this.mapper = mapper;
        }

        public CityDto CityUpdate(CityDto cityViewModel)
        {
            var city = cityRepository.CityUpdate(mapper.Map<City>(cityViewModel));
            return mapper.Map<CityDto>(city);
        }
    }
}