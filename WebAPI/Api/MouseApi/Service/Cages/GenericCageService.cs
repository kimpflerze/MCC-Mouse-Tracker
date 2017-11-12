using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.Cages;
using MouseApi.Patchers.Cages;
using MouseApi.Validator.Cages;

namespace MouseApi.Service.Cages
{
    public class GenericCageService : BaseService<GenericCageEntity, GenericCageValidator, IGenericCageFilterProvider, IGenericCagePatcher>, IGenericCageService 
    {
        public GenericCageService(MouseTrackDbContext dbContext
            , IBaseRepository<GenericCageEntity> repository
            , GenericCageValidator validator
            , IGenericCageFilterProvider provider
            , IGenericCagePatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {

        }
    }
}