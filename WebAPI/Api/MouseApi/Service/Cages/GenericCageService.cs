using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.Cages;
using MouseApi.Validator.Cages;

namespace MouseApi.Service.Cages
{
    public class GenericCageService : BaseService<GenericCageEntity, GenericCageValidator, IGenericCageFilterProvider>, IGenericCageService 
    {
        public GenericCageService(MouseTrackDbContext dbContext
            , IBaseRepository<GenericCageEntity> repository
            , GenericCageValidator validator
            , IGenericCageFilterProvider provider) : base(dbContext, repository, validator, provider)
        {

        }
    }
}