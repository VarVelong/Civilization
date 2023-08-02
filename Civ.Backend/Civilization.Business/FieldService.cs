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
        private ISaveRepository saveRepository;

        public FieldService(IFieldRepository fieldRepository, IMapper mapper, ISaveRepository saveRepository)
        {
            this.fieldRepository = fieldRepository;
            this.mapper = mapper;
            this.saveRepository = saveRepository;
        }

        //TODO ADD WORKING WITH SAVE REPOSITORY

        public void FieldAdd(List<CellDto> cells)
        {
            Save save = saveRepository.SaveAdd(new Save { Id = cells.First().SaveId, SavedOn = DateTime.UtcNow });

            foreach(var cell in cells)  
            {
                cell.SaveId = save.Id;
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