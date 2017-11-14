using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the Settings resource.
    /// </summary>
    public class SettingsProfile : BaseProfile<SettingsCreator, SettingsModel, SettingsEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="SettingsProfile"/>.
        /// </summary>
        public SettingsProfile() : base()
        {
        }
    }
}