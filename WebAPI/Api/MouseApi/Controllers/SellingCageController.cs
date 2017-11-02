using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Cages;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class SellingCageController : BaseController<ISellingCageService, SellingCageCreator, SellingCageModel, SellingCageEntity>
    {
        public SellingCageController(ISellingCageService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}