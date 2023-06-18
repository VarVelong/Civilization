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
        private IMapper mapper;

        public FieldController(IFieldService fieldService, IMapper mapper)
        {
            this.fieldService = fieldService;
            this.mapper = mapper;
        } 

        [HttpPost("create")]
        public IActionResult Create(List<CellViewModel> cells)
        {
            fieldService.FieldAdd(mapper.Map<List<CellDTO>>(cells));
            return Ok(new { value = "dupa" });
        }


    }
}
