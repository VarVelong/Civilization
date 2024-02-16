using Microsoft.AspNetCore.Mvc;
using Civilization.Models;
using Civilization.Business;
using AutoMapper;
using Civilization.Business.Models;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("game")]

    public class SaveController : ControllerBase
    {
        private IFieldService fieldService;
        private ISaveService saveService;
        private IMapper mapper;

        public SaveController(IFieldService fieldService, ISaveService saveService, IMapper mapper)
        {
            this.fieldService = fieldService;
            this.saveService = saveService;
            this.mapper = mapper;
        } 

        [HttpPost("save")]
        public IActionResult Create(SaveCreateViewModel saveViewModel)
        {
            var save = saveService.FieldAdd(mapper.Map<List<CellDto>>(saveViewModel.Cells), mapper.Map<SaveTypeDto>(saveViewModel.SaveType));
            return Ok(mapper.Map<SaveViewModel>(save));
        }

        [HttpPatch("save")]
        public IActionResult Update(SaveUpdateViewModel saveViewModel)
        {
            var save = saveService.FieldUpdate(mapper.Map<List<CellDto>>(saveViewModel.Cells), mapper.Map<SaveTypeDto>(saveViewModel.SaveType), saveViewModel.SaveSlotNumber);
            return Ok(mapper.Map<SaveViewModel>(save));
        }

        //todo fix once front end is done
        [HttpDelete("save")]
        public IActionResult Delete(List<CellViewModel> cells)
        {
            //fieldService.FieldAdd(mapper.Map<List<CellDto>>(cells));
            return Ok(new { value = "test" });
        }

        [HttpGet("save/{saveId}")]        
        public IActionResult Get(int saveId)
        {
            var cells = fieldService.FieldGet(saveId);
            return Ok(mapper.Map<List<CellViewModel>>(cells));
        }

        [HttpGet("save")]
        public IActionResult Get()
        {
            var cells = saveService.GetList();
            return Ok(mapper.Map<List<SaveViewModel>>(cells));
        }
    }
}
