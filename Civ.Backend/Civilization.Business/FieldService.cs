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

        private const int maxIdForUserSaves = 15;
        private const int saveStateSlotId = 16;
        private const int minIdForAutoSaves = 17;
        private const int maxIdForAutoSaves = 19;

        public FieldService(IFieldRepository fieldRepository, IMapper mapper, ISaveRepository saveRepository)
        {
            this.fieldRepository = fieldRepository;
            this.mapper = mapper;
            this.saveRepository = saveRepository;
        }

        public Save FieldAdd(List<CellDto> cells, SaveTypeDto saveType)
        {
            switch (saveType)
            {
                case SaveTypeDto.UserSave:
                    {
                        return SaveAdd(cells, saveRepository.SaveGet().Max(s => s.Id <= maxIdForUserSaves ? s.Id : 0) + 1);
                    }
                case SaveTypeDto.AutoSave:
                    {
                        return SaveAdd(cells, saveRepository.SaveGet().Max(s => minIdForAutoSaves >= s.Id && s.Id <= maxIdForAutoSaves ? s.Id : 0) + 1);
                    }
                case SaveTypeDto.SaveState:
                    {
                        return SaveAdd(cells, saveStateSlotId);
                    }
            }
        }

        public Save FieldUpdate(List<CellDto> cells, SaveTypeDto saveType, int? saveSlotNumber) 
        {
            switch (saveType)
            {
                case SaveTypeDto.UserSave:
                    {
                        return SaveAdd(cells, saveSlotNumber.Value);
                    }
                case SaveTypeDto.AutoSave:
                    {
                        return SaveAdd(cells, minIdForAutoSaves + saveSlotNumber.Value);
                    }
                case SaveTypeDto.SaveState:
                    {
                        return SaveAdd(cells, saveStateSlotId);
                    }
            }
        }


        private Save SaveAdd(List<CellDto> cells, int saveId)
        {
            Save save = saveRepository.SaveAdd(new Save { Id = saveId, SavedOn = DateTime.UtcNow });

            foreach (var cell in cells)
            {
                cell.SaveId = save.Id;
                fieldRepository.FieldAdd(mapper.Map<Cell>(cell));
            }

            return save;
        }

        private void SaveUpdate(List<CellDto> cells, int saveId)
        {
            foreach (var cell in cells)
            {
                fieldRepository.FieldUpdate(mapper.Map<Cell>(cell));
            }

            var save = saveRepository.SaveUpdate(new Save { Id = saveId, SavedOn = DateTime.UtcNow });
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