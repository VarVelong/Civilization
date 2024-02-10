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

        public void FieldAdd(List<CellDto> cells, SaveTypeDto saveType)
        {
            const int maxIdForUserSaves = 15;
            const int saveStateSlotId = 16;
            const int minIdForAutoSaves = 17;
            const int maxIdForAutoSaves = 19;

            switch (saveType)
            {
                case SaveTypeDto.UserSave:
                    {
                        SaveAdd(cells, saveRepository.SaveGet().Max(s => s.Id <= maxIdForUserSaves ? s.Id : 0) + 1);
                        break;
                    }
                case SaveTypeDto.AutoSave:
                    {
                        SaveAdd(cells, saveRepository.SaveGet().Max(s => minIdForAutoSaves >= s.Id && s.Id <= maxIdForAutoSaves ? s.Id : 0) + 1);
                        break;
                    }
                case SaveTypeDto.SaveState:
                    {
                        SaveAdd(cells, saveStateSlotId);
                        break;
                    }
            }

        }
        public void FieldUpdate(List<CellDto> cells, SaveTypeDto saveType, int saveSlotNumber)
        {
            switch (saveType)
            {
                case SaveTypeDto.UserSave:
                    {
                        SaveAdd(cells, saveRepository.SaveGet().Max(s => s.Id <= maxIdForUserSaves ? s.Id : 0) + 1);
                        break;
                    }
                case SaveTypeDto.AutoSave:
                    {
                        SaveAdd(cells, saveRepository.SaveGet().Max(s => minIdForAutoSaves >= s.Id && s.Id <= maxIdForAutoSaves ? s.Id : 0) + 1);
                        break;
                    }
                case SaveTypeDto.SaveState:
                    {
                        SaveAdd(cells, saveStateSlotId);
                        break;
                    }
            }
        }


        private void SaveAdd(List<CellDto> cells, int saveId)
        {
            Save save = saveRepository.SaveAdd(new Save { Id = saveId, SavedOn = DateTime.UtcNow });

            foreach (var cell in cells)
            {
                cell.SaveId = save.Id;
                fieldRepository.FieldAdd(mapper.Map<Cell>(cell));
            }
        }

        private void SaveUpdate(List<CellDto> cells, int saveId)
        {
            foreach (var cell in cells)
            {
                fieldRepository.FieldUpdate(mapper.Map<Cell>(cell));
            }

            saveRepository.SaveUpdate(new Save { Id = saveId, SavedOn = DateTime.UtcNow });

            foreach (var cell in cells)
            {
                cell.SaveId = saveId;
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
    }
}