using AutoMapper;
using Civilization.Business.Models;
using Civilization.Data.Models;
using Civilization.Models;

namespace Civilization
{
    public static class MapperConfig
    {
        public static void AddMapping(this IServiceCollection services)
        {
            //Provide all the Mapping Configuration
            services.AddSingleton(sp => new MapperConfiguration(cfg =>
            {
                //Configuring Mapping
                cfg.CreateMap<CellViewModel, CellDto>();
                cfg.CreateMap<CellDto, Cell>();

                cfg.CreateMap<CityViewModel, CityDto>();
                cfg.CreateMap<CityDto, City>();

                cfg.CreateMap<SaveViewModel, SaveDto>();
                cfg.CreateMap<SaveDto, Save>();

                cfg.CreateMap<CellDto, CellViewModel>();
                cfg.CreateMap<CellSummary, CellDto>()
                    .ForMember(dest => dest.City, opt => opt.MapFrom(x => x.CityName != null ? new CityDto() { Name = x.CityName } : null));

                cfg.CreateMap<SaveDto, SaveViewModel>();
                cfg.CreateMap<Save, SaveDto>();

                cfg.CreateMap<CityDto, CityViewModel>();
                cfg.CreateMap<City, CityDto>();
                //Any Other Mapping Configuration ....
            }));

            //Adding mapping to the project
            services.AddScoped(sp => sp.GetService<MapperConfiguration>().CreateMapper(sp.GetService));
        }
    }
}
