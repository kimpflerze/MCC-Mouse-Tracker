using MouseApi.Entities;
using MouseApi.FilterProviders.CagesForOrder;
using MouseApi.Patchers.CagesForOrder;
using MouseApi.Validator.CagesForOrder;
using MouseApi.DataAccess;

namespace MouseApi.Service.CagesForOrder
{
    public class CagesForOrderService : BaseService<CagesForOrderEntity, ICagesForOrderValidator, ICagesForOrderFilterProvider, ICagesForOrderPatcher>, ICagesForOrderService
    {
        public CagesForOrderService(MouseTrackDbContext dbContext, 
            IBaseRepository<CagesForOrderEntity> repository, 
            ICagesForOrderValidator validator, 
            ICagesForOrderFilterProvider provider, 
            ICagesForOrderPatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
        }
    }
}