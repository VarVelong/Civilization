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
                cfg.CreateMap<CellViewModel, CellDto>().ReverseMap();
                cfg.CreateMap<CellDto, Cell>();

                cfg.CreateMap<CityViewModel, CityDto>().ReverseMap();
                cfg.CreateMap<CityDto, City>().ReverseMap();

                cfg.CreateMap<SaveViewModel, SaveDto>().ReverseMap();
                cfg.CreateMap<SaveDto, Save>().ReverseMap();

                 cfg.CreateMap<CellSummary, CellDto>()
                    .ForMember(dest => dest.City, opt => opt.MapFrom(x => x.CityName != null ? new CityDto() { Name = x.CityName } : null));

                //Any Other Mapping Configuration ....
            }));

            //Adding mapping to the project
            services.AddScoped(sp => sp.GetService<MapperConfiguration>().CreateMapper(sp.GetService));
        }
    }
}
