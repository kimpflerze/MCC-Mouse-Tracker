using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the SellingCage resource.
    /// </summary>
    public class SellingCageProfile : BaseProfile<SellingCageCreator, SellingCageModel, SellingCageEntity> 
    {
        /// <summary>
        /// Creates a new instance of <see cref="SellingCageProfile"/>.
        /// </summary>
        public SellingCageProfile()
        {
            CreateMap<SellingCageCreator, SellingCageEntity>();
            CreateMap<SellingCageEntity, SellingCageModel>()
                .ForMember(model => model.MarkedForOrder, exp => exp.ResolveUsing(entity => CheckForOrder(entity)));
        }

        private bool CheckForOrder(SellingCageEntity entity)
        {
            var orders = entity.CagesForOrder;
            if (orders != null)
            {
                foreach (var order in orders)
                {
                    if (order.Order.Active == 1) return true;
                }
            }
            return false;
        }
    }
}