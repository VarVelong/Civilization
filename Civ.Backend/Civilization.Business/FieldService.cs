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

        //TODO ADD WORKING WITH SAVE REPOSITORY

        public void FieldAdd(List<CellDto> cells)
        {
            foreach(var cell in cells)
            {
                fieldRepository.FieldAdd(mapper.Map<Cell>(cell));
            }
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

        public void FieldUpdate(List<CellDto> cells)
        {
            foreach (var cell in cells)
            {
                fieldRepository.FieldUpdate(mapper.Map<Cell>(cell));
            }
        }
    }
}