using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the ParentCageLookup resource.
    /// </summary>
    public class ParentCageLookupProfile : BaseProfile<ParentCageLookupCreator, ParentCageLookupModel, ParentCageLookupEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="ParentCageLookupProfile"/>.
        /// </summary>
        public ParentCageLookupProfile() : base()
        {
        }
    }
}