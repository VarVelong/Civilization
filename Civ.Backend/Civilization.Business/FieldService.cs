using Civilization.Data;
using Civilization.Business.Models;
using AutoMapper;
using Civilization.Data.Models;

namespace Civilization.Business
{
    public class FieldService : IFieldService
    {
        private IFieldRepository fieldRepository;
        private IMapper mapper;
        public FieldService(IFieldRepository fieldRepository, IMapper mapper)
        {
            this.fieldRepository = fieldRepository;
            this.mapper = mapper;
        }        

        public void FieldAdd(List<CellDTO> cells)
        {
            foreach(var cell in cells)
            {
                fieldRepository.FieldAdd(mapper.Map<Cell>(cell));
            }
        }

        public void FieldDelete(List<CellDTO> cells)
        {
            throw new NotImplementedException();
        }

        public List<CellDTO> FieldGet()
        {
            var result = fieldRepository.FieldGet();
            return mapper.Map<List<CellDTO>>(result);
        }

        public void FieldUpdate(List<CellDTO> cells)
        {
            foreach (var cell in cells)
            {
                fieldRepository.FieldUpdate(mapper.Map<Cell>(cell));
            }
        }
    }
}