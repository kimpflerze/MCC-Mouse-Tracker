using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    public class CagesForOrderProfile : BaseProfile<CagesForOrderCreator, CagesForOrderModel, CagesForOrderEntity>
    {
        public CagesForOrderProfile() : base()
        {
        }
    }
}