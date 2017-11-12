using AutoMapper;
using Microsoft.Practices.Unity;
using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.Entities.Transaction;
using MouseApi.FilterProviders.Alert;
using MouseApi.FilterProviders.BreedingMale;
using MouseApi.FilterProviders.Cages;
using MouseApi.FilterProviders.LitterLog;
using MouseApi.FilterProviders.ParentCageLookup;
using MouseApi.FilterProviders.Transaction;
using MouseApi.Patchers.Alert;
using MouseApi.Patchers.BreedingMale;
using MouseApi.Patchers.Cages;
using MouseApi.Patchers.LitterLog;
using MouseApi.Patchers.ParentCageLookup;
using MouseApi.Patchers.Transaction;
using MouseApi.Profiles;
using MouseApi.Service.Alert;
using MouseApi.Service.Breeder;
using MouseApi.Service.Cages;
using MouseApi.Service.LitterLog;
using MouseApi.Service.ParentCageLookup;
using MouseApi.Service.Transaction;
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


            container.RegisterType<MouseTrackDbContext, MouseTrackDbContext>(new ContainerControlledLifetimeManager());
            // register all your components with the container here
            // it is NOT necessary to register your controllers
            container.RegisterType<IBreedingCageFilterProvider, BreedingCageFilterProvider>();
            container.RegisterType<IGenericCageFilterProvider, GenericCageFilterProvider>();
            container.RegisterType<IBreedingMaleFilterProvider, BreedingMaleFilterProvider>();
            container.RegisterType<IParentCageLookupFilterProvider, ParentCageLookupFilterProvider>();
            container.RegisterType<ILitterLogFilterProvider, LitterLogFilterProvider>();
            container.RegisterType<ISellingCageFilterProvider, SellingCageFilterProvider>();
            container.RegisterType<ITransactionFilterProvider, TransactionFilterProvider>();
            container.RegisterType<IAlertFilterProvider, AlertFilterProvider>();

            container.RegisterType<IBreedingCagePatcher, BreedingCagePatcher>();
            container.RegisterType<IGenericCagePatcher, GenericCagePatcher>();
            container.RegisterType<IBreedingMalePatcher, BreedingMalePatcher>();
            container.RegisterType<IParentCageLookupPatcher, ParentCageLookupPatcher>();
            container.RegisterType<ISellingCagePatcher, SellingCagePatcher>();
            container.RegisterType<ILitterLogPatcher, LitterLogPatcher>();
            container.RegisterType<ITransactionPatcher, TransactionPatcher>();
            container.RegisterType<IAlertPatcher, AlertPatcher>();



            container.RegisterType<BreedingCageValidator, BreedingCageValidator>();

            container.RegisterType<IBaseRepository<BreedingCageEntity>, BaseRepository<BreedingCageEntity>>();
            container.RegisterType<IBaseRepository<GenericCageEntity>, BaseRepository<GenericCageEntity>>();
            container.RegisterType<IBaseRepository<BreedingMaleEntity>, BaseRepository<BreedingMaleEntity>>();
            container.RegisterType<IBaseRepository<LitterLogEntity>, BaseRepository<LitterLogEntity>>();
            container.RegisterType<IBaseRepository<ParentCageLookupEntity>, BaseRepository<ParentCageLookupEntity>>();
            container.RegisterType<IBaseRepository<SellingCageEntity>, BaseRepository<SellingCageEntity>>();
            container.RegisterType<IBaseRepository<TransactionEntity>, BaseRepository<TransactionEntity>>();
            container.RegisterType<IBaseRepository<AlertEntity>, BaseRepository<AlertEntity>>();

            container.RegisterType<IGenericCageService, GenericCageService>();
            container.RegisterType<IBreedingCageService, BreedingCageService>();
            container.RegisterType<IBreedingMaleService, BreedingMaleService>();
            container.RegisterType<ILitterLogService, LitterLogService>();
            container.RegisterType<IParentCageLookupService, ParentCageLookupService>();
            container.RegisterType<ISellingCageService, SellingCageService>();
            container.RegisterType<ITransactionService, TransactionService>();
            container.RegisterType<IAlertService, AlertService>();

            container.RegisterType<IMapper, Mapper>(new InjectionConstructor(
                new MapperConfiguration(cfg => 
                {
                    cfg.AddProfile<GenericCageProfile>();
                    cfg.AddProfile<BreedingCageProfile>();
                    cfg.AddProfile<ParentCageLookupProfile>();
                    cfg.AddProfile<BreedingMaleProfile>();
                    cfg.AddProfile<LitterLogProfile>();
                    cfg.AddProfile<SellingCageProfile>();
                    cfg.AddProfile<TransactionProfile>();
                    cfg.AddProfile<AlertProfile>();
                } )));
            
            GlobalConfiguration.Configuration.DependencyResolver = new UnityDependencyResolver(container);
        }
    }
}