using Microsoft.AspNetCore.Mvc;
using Civilization.Models;
using Civilization.Business;
using AutoMapper;
using Civilization.Business.Models;

namespace Civilization.Controllers
{
    [ApiController]
    [Route("game")]

    public class CityController : ControllerBase
    {

        private ICityService cityService;
        private IMapper mapper;

        public CityController(ICityService cityService, IMapper mapper)
        {
            this.cityService = cityService;
            this.mapper = mapper;
        }

        [HttpPatch("city")]
        public IActionResult Update(CityViewModel cityViewModel)
        {
            var city = cityService.CityUpdate(mapper.Map<CityDto>(cityViewModel));
            return Ok(mapper.Map<CityViewModel>(city));
        }




        //[HttpPost("city")]
        //public IActionResult Create(CityCreateViewModel cityViewModel)
        //{
        //    var city = cityService.FieldAdd(mapper.Map<List<CellDto>>(cityViewModel.Cells), mapper.Map<CityTypeDto>(cityViewModel.CityType));
        //    return Ok(mapper.Map<CityViewModel>(city));
        //}
        //todo fix once front end is done
        //        [HttpDelete("city")]
        //        public IActionResult Delete(List<CellViewModel> cells)
        //        {
        //            //fieldService.FieldAdd(mapper.Map<List<CellDto>>(cells));
        //            return Ok(new { value = "test" });
        //        }

        //        [HttpGet("city/{cityId}")]        
        //        public IActionResult Get(int cityId)
        //        {
        //            var cells = fieldService.FieldGet(cityId);
        //            return Ok(mapper.Map<List<CellViewModel>>(cells));
        //        }

        //        [HttpGet("city")]
        //        public IActionResult Get()
        //        {
        //            var cells = cityService.GetList();
        //            return Ok(mapper.Map<List<CityViewModel>>(cells));
        //        }
    }
}
