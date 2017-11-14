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
            CreateMap<SellingCageModel, SellingCageEntity>().ReverseMap();
        }
    }
}