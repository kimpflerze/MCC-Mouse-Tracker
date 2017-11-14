using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the LitterLog resource.
    /// </summary>
    public class LitterLogProfile : BaseProfile<LitterLogCreator, LitterLogModel, LitterLogEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="LitterLogProfile"/>.
        /// </summary>
        public LitterLogProfile() : base()
        {
        }
    }
}