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

                cfg.CreateMap<SaveViewModel, SaveDto>();
                cfg.CreateMap<SaveDto, Save>();

                cfg.CreateMap<CellDto, CellViewModel>();
                cfg.CreateMap<Cell, CellDto>();

                cfg.CreateMap<SaveDto, SaveViewModel>();
                cfg.CreateMap<Save, SaveDto>();
                //Any Other Mapping Configuration ....
            }));

            //Adding mapping to the project
            services.AddScoped(sp => sp.GetService<MapperConfiguration>().CreateMapper(sp.GetService));
        }
    }
}
