using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.CagesForOrder;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class CageOrderController : BaseController<ICagesForOrderService, CagesForOrderCreator, CagesForOrderModel, CagesForOrderEntity>
    {
        public CageOrderController(ICagesForOrderService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}