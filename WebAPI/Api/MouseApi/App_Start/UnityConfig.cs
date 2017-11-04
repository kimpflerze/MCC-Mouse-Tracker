using AutoMapper;
using Microsoft.Practices.Unity;
using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.BreedingMale;
using MouseApi.FilterProviders.Cages;
using MouseApi.FilterProviders.LitterLog;
using MouseApi.FilterProviders.ParentCageLookup;
using MouseApi.Profiles;
using MouseApi.Service.Breeder;
using MouseApi.Service.Cages;
using MouseApi.Service.LitterLog;
using MouseApi.Service.ParentCageLookup;
using MouseApi.Validator.Cages;
using System.Web.Http;
using Unity.WebApi;

namespace MouseApi
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers
            container.RegisterType<IBreedingCageFilterProvider, BreedingCageFilterProvider>();
            container.RegisterType<IGenericCageFilterProvider, GenericCageFilterProvider>();
            container.RegisterType<IBreedingMaleFilterProvider, BreedingMaleFilterProvider>();
            container.RegisterType<IParentCageLookupFilterProvider, ParentCageLookupFilterProvider>();
            container.RegisterType<ILitterLogFilterProvider, LitterLogFilterProvider>();
            container.RegisterType<ISellingCageFilterProvider, SellingCageFilterProvider>();

            container.RegisterType<BreedingCageValidator, BreedingCageValidator>();

            container.RegisterType<IBaseRepository<BreedingCageEntity>, BaseRepository<BreedingCageEntity>>();
            container.RegisterType<IBaseRepository<GenericCageEntity>, BaseRepository<GenericCageEntity>>();
            container.RegisterType<IBaseRepository<BreedingMaleEntity>, BaseRepository<BreedingMaleEntity>>();
            container.RegisterType<IBaseRepository<LitterLogEntity>, BaseRepository<LitterLogEntity>>();
            container.RegisterType<IBaseRepository<ParentCageLookupEntity>, BaseRepository<ParentCageLookupEntity>>();
            container.RegisterType<IBaseRepository<SellingCageEntity>, BaseRepository<SellingCageEntity>>();

            container.RegisterType<IGenericCageService, GenericCageService>();
            container.RegisterType<IBreedingCageService, BreedingCageService>();
            container.RegisterType<IBreedingMaleService, BreedingMaleService>();
            container.RegisterType<ILitterLogService, LitterLogService>();
            container.RegisterType<IParentCageLookupService, ParentCageLookupService>();
            container.RegisterType<ISellingCageService, SellingCageService>();
            container.RegisterType<IMapper, Mapper>(new InjectionConstructor(
                new MapperConfiguration(cfg => 
                {
                    cfg.AddProfile<GenericCageProfile>();
                    cfg.AddProfile<BreedingCageProfile>();
                    cfg.AddProfile<ParentCageLookupProfile>();
                    cfg.AddProfile<BreedingMaleProfile>();
                    cfg.AddProfile<LitterLogProfile>();
                    cfg.AddProfile<SellingCageProfile>();
                } )));
            
            GlobalConfiguration.Configuration.DependencyResolver = new UnityDependencyResolver(container);
        }
    }
}