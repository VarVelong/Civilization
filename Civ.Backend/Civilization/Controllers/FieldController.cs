using Civilization.Models;
using Microsoft.AspNetCore.Mvc;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("Field")]

    public class FieldController: ControllerBase
    {
        [HttpPost("create")]
        public IActionResult Create(List<Cell> cells)
        {
            return Ok(new { value = "dupa" });
        }


    }
}
