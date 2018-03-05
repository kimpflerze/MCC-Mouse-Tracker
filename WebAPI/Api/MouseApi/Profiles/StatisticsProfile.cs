using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class StatisticsProfile : Profile
    {
        public StatisticsProfile()
        {
            CreateMap<StatisticsCreator, StatisticsEntity>();
            CreateMap<StatisticsEntity, StatisticsModel>();
        }
    }
}