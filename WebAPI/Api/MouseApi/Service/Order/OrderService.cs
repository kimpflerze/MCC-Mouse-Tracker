using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.Order;
using MouseApi.Patchers.Order;
using MouseApi.Validator.Order;

namespace MouseApi.Service.Order
{
    public class OrderService : BaseService<OrderEntity, IOrderValidator, IOrderFilterProvider, IOrderPatcher>, IOrderService
    {
        public OrderService(MouseTrackDbContext dbContext,
            IBaseRepository<OrderEntity> repository,
            IOrderValidator validator,
            IOrderFilterProvider filterProvider,
            IOrderPatcher patcher) : base(dbContext, repository, validator, filterProvider, patcher)
        {

        }
    }
}