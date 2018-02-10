using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class OrderProfile : BaseProfile<OrderCreator, OrderModel, OrderEntity>
    {
        public OrderProfile() : base()
        {
            CreateMap<OrderEntity, OrderModel>()
                .ForMember(model => model.Charged, src => src.ResolveUsing(entity => MapCharged(entity.Charged)));
        }

        private string MapCharged(int intValue)
        {
            if(intValue == 1)
            {
                return "Yes";
            }
            else
            {
                return "No";
            }
        }
    }
}