using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.ParentCageLookup;
using MouseApi.Patchers.ParentCageLookup;
using MouseApi.Validator.ParentCageLookup;

namespace MouseApi.Service.ParentCageLookup
{
    public class ParentCageLookupService : BaseService<ParentCageLookupEntity, IParentCageLookupValidator, IParentCageLookupFilterProvider, IParentCageLookupPatcher>, IParentCageLookupService
    {
        public ParentCageLookupService(MouseTrackDbContext dbContext
            , IBaseRepository<ParentCageLookupEntity> repository
            , IParentCageLookupValidator validator
            , IParentCageLookupFilterProvider provider
            , IParentCageLookupPatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {

        }
    }
}