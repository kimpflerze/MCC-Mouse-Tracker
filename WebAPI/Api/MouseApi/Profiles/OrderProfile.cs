using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class OrderProfile : BaseProfile<OrderCreator, OrderModel, OrderEntity>
    {
        public OrderProfile() : base()
        {

        }
    }
}