using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for Alert resource. 
    /// </summary>
    public class AlertProfile : BaseProfile<AlertCreator, AlertModel, AlertEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="AlertProfile"/>.
        /// </summary>
        public AlertProfile() : base()
        {
        }
    }
}