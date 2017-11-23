using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Alert;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class AlertController : BaseController<IAlertService, AlertCreator, AlertModel, AlertEntity>
    {
        public AlertController(IAlertService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }

        public AlertModel Delete(string id)
        {
            return _mapper.Map<AlertModel>(_service.Delete(id));
        }
    }
}