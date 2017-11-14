using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class LitterLogProfile : BaseProfile<LitterLogCreator, LitterLogModel, LitterLogEntity>
    {
        public LitterLogProfile() : base()
        {
        }
    }
}