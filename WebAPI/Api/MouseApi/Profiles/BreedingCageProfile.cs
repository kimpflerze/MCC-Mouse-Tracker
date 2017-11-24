using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the BreedingCage resource.
    /// </summary>
    public class BreedingCageProfile : BaseProfile<BreedingCageCreator, BreedingCageModel, BreedingCageEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="BreedingCageProfile"/>.
        /// </summary>
        public BreedingCageProfile() 
        {
            CreateMap<BreedingCageCreator, BreedingCageEntity>();
            CreateMap<BreedingCageModel, BreedingCageEntity>().ReverseMap();
        }
    }
}