using AutoMapper;
using Civilization.Business.Models;
using Civilization.Data;
using Civilization.Data.Models;

namespace Civilization.Business
{
    public class SaveService : ISaveService
    {
        private ISaveRepository saveRepository;
        private IFieldRepository fieldRepository;
        private IMapper mapper;

        private const int maxIdForUserSaves = 15;
        private const int saveStateSlotId = 16;
        private const int minIdForAutoSaves = 17;
        private const int maxIdForAutoSaves = 19;

        public SaveService(ISaveRepository saveRepository, IFieldRepository fieldRepository, IMapper mapper)
        {
            this.saveRepository = saveRepository;
            this.fieldRepository = fieldRepository;
            this.mapper = mapper;
        }

        public IEnumerable<SaveDto> GetList()
        {
            var result = saveRepository.SaveGet();
            return mapper.Map<List<SaveDto>>(result);
        }

        public SaveDto FieldAdd(List<CellDto> cells, SaveTypeDto saveType)
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

            throw new InvalidDataException("Save type is not valid.");
        }

        public SaveDto FieldUpdate(List<CellDto> cells, SaveTypeDto saveType, int? saveSlotNumber)
        {
            switch (saveType)
            {
                case SaveTypeDto.UserSave:
                    {
                        return SaveUpdate(cells, saveSlotNumber.Value);
                    }
                case SaveTypeDto.AutoSave:
                    {
                        var oldestAutoSave = saveRepository.SaveGet().OrderByDescending(s => s.SavedOn).First(s => minIdForAutoSaves >= s.Id && s.Id <= maxIdForAutoSaves);
                        return SaveUpdate(cells, oldestAutoSave.Id);
                    }
                case SaveTypeDto.SaveState:
                    {
                        return SaveUpdate(cells, saveStateSlotId);
                    }
            }

            throw new InvalidDataException("Save type is not valid.");
        }


        private SaveDto SaveAdd(List<CellDto> cells, int saveId)
        {
            Save save = saveRepository.SaveAdd(new Save { Id = saveId, SavedOn = DateTime.UtcNow });

            foreach (var cell in cells)
            {
                cell.SaveId = save.Id;
                fieldRepository.FieldAdd(mapper.Map<Cell>(cell));
            }

            return mapper.Map<SaveDto>(save);
        }

        private SaveDto SaveUpdate(List<CellDto> cells, int saveId)
        {
            foreach (var cell in cells)
            {
                fieldRepository.FieldUpdate(mapper.Map<Cell>(cell));
            }

            var save = saveRepository.SaveUpdate(new Save { Id = saveId, SavedOn = DateTime.UtcNow });
            return mapper.Map<SaveDto>(save);
        }
    }
}
