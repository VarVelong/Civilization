using Microsoft.AspNetCore.Mvc;
using Civilization.Models;
using Civilization.Business;
using AutoMapper;
using Civilization.Business.Models;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("Field")]

    public class FieldController: ControllerBase
    {
        private IFieldService fieldService;
        private ISaveService saveService;
        private IMapper mapper;

        public FieldController(IFieldService fieldService, ISaveService saveService, IMapper mapper)
        {
            this.fieldService = fieldService;
            this.saveService = saveService;
            this.mapper = mapper;
        } 

        [HttpPost("create")]
        public IActionResult Create(FieldCreateViewModel saveViewModel)
        {
            fieldService.FieldAdd(mapper.Map<List<CellDto>>(saveViewModel.Cells), mapper.Map<SaveTypeDto>(saveViewModel.SaveType));
            return Ok(new { value = "dupa" });
        }

        [HttpPatch("update")]
        public IActionResult Update(FieldCreateViewModel saveViewModel)
        {
            //add parameter save slot nullable
            fieldService.FieldUpdate(mapper.Map<List<CellDto>>(saveViewModel.Cells), mapper.Map<SaveTypeDto>(saveViewModel.SaveType), saveViewModel.SaveSlotNumber);
            return Ok(new { value = "dupa" });
        }

        //todo fix once front end is done
        [HttpDelete("delete")]
        public IActionResult Delete(List<CellViewModel> cells)
        {
            //fieldService.FieldAdd(mapper.Map<List<CellDto>>(cells));
            return Ok(new { value = "dupa" });
        }

        [HttpGet("get/{saveId}")]        
        public IActionResult Get(int saveId)
        {
            var cells = fieldService.FieldGet(saveId);
            return Ok(mapper.Map<List<CellViewModel>>(cells));
        }

        [HttpGet("/save")]
        public IActionResult Get()
        {
            var cells = saveService.GetList();
            return Ok(mapper.Map<List<SaveViewModel>>(cells));
        }
    }
}
