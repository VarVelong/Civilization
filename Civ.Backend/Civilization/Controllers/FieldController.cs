using Civilization.Models;
using Microsoft.AspNetCore.Mvc;
using Civilization.Business;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("Field")]

    public class FieldController: ControllerBase
    {
        private FieldService fieldService = new FieldService();


        [HttpPost("create")]
        public IActionResult Create(List<Cell> cells)
        {
            fieldService.FieldAdd(cells);
            return Ok(new { value = "dupa" });
        }


    }
}
