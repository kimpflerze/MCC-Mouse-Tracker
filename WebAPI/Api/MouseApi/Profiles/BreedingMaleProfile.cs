using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile the BreedingMale resource.
    /// </summary>
    public class BreedingMaleProfile : BaseProfile<BreedingMaleCreator, BreedingMaleModel, BreedingMaleEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="BreedingMaleProfile"/>.
        /// </summary>
        public BreedingMaleProfile()
        {
            CreateMap<BreedingMaleCreator, BreedingMaleEntity>();
            CreateMap<BreedingMaleModel, BreedingMaleEntity>().ReverseMap();
        }
    }
}