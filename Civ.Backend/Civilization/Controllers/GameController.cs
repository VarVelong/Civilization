using Microsoft.AspNetCore.Mvc;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("Game")]
    public class GameController : ControllerBase
    {


        public GameController()
        {

        }

        [HttpGet("version")]
        public IActionResult Version() 
        {
            return Ok(new{value="dupa"});
        }


//        [HttpGet(Name = "GetWeatherForecast")]
//        public IEnumerable<WeatherForecast> Get()
//        {
//            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
//            {
//                Date = DateTime.Now.AddDays(index),
//                TemperatureC = Random.Shared.Next(-20, 55),
//                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
//            })
//            .ToArray();
//        }
    }
}