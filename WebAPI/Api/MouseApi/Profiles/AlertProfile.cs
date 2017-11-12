using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class AlertProfile : BaseProfile<AlertCreator, AlertModel, AlertEntity>
    {
        public AlertProfile() : base()
        {
        }
    }
}