using Civilization.Business;
using Civilization.Data;

namespace Civilization
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddScoped<IFieldService, FieldService>();
            builder.Services.AddScoped<ISaveService, SaveService>();
            builder.Services.AddScoped<IFieldRepository, FieldRepository>();
            builder.Services.AddScoped<ISaveRepository, SaveRepository>();

            builder.Services.AddMapping();

            // Add services to the container.
            builder.Services.AddControllers(options => options.SuppressImplicitRequiredAttributeForNonNullableReferenceTypes = true);

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();
            app.UseCors(builder => builder
                             .AllowAnyHeader()
                             .AllowAnyMethod()
                             .SetIsOriginAllowed((host) => true)
                             .AllowCredentials()
                         );

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}