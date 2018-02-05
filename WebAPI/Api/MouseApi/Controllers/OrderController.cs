using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Order;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class OrderController : BaseController<IOrderService, OrderCreator, OrderModel, OrderEntity>
    {
        public OrderController(IOrderService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}