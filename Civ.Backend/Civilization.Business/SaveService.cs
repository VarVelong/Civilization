using AutoMapper;
using Civilization.Business.Models;
using Civilization.Data;

namespace Civilization.Business
{
    public class SaveService : ISaveService
    {
        private ISaveRepository saveRepository;
        private IMapper mapper;
        public SaveService(ISaveRepository saveRepository, IMapper mapper)
        {
            this.saveRepository = saveRepository;
            this.mapper = mapper;
        }

        public IEnumerable<SaveDto> GetList()
        {
            var result = saveRepository.SaveGet();
            return mapper.Map<List<SaveDto>>(result);
        }
    }
}
