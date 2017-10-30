using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.ParentCageLookup;
using MouseApi.Validator.ParentCageLookup;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace MouseApi.Service.ParentCageLookup
{
    public class ParentCageLookupService : BaseService<ParentCageLookupEntity, ParentCageLookupValidator, IParentCageLookupFilterProvider>, IParentCageLookupService
    {
        public ParentCageLookupService(MouseTrackDbContext dbContext
            , IBaseRepository<ParentCageLookupEntity> repository
            , ParentCageLookupValidator validator
            , IParentCageLookupFilterProvider provider) : base(dbContext, repository, validator, provider)
        {

        }
    }
}