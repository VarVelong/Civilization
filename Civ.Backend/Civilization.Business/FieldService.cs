using Civilization.Data;
using Civilization.Business.Models;
using AutoMapper;

namespace Civilization.Business
{
    public class FieldService : IFieldService
    {
        private IFieldRepository fieldRepository;
        private IMapper mapper;

        public FieldService(IFieldRepository fieldRepository, IMapper mapper, ISaveRepository saveRepository)
        {
            this.fieldRepository = fieldRepository;
            this.mapper = mapper;
        }

        public void FieldDelete(List<CellDto> cells)
        {
            throw new NotImplementedException();
        }

        public List<CellDto> FieldGet(int saveId)
        {
            var result = fieldRepository.FieldGet(saveId);
            return mapper.Map<List<CellDto>>(result);
        }
    }
}