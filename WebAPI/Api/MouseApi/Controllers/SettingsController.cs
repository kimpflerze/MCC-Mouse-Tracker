using System.Net.Http;
using System.Web.Http;
using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Settings;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Controllers
{
    public class SettingsController : BaseController<ISettingsService, SettingsCreator, SettingsModel, SettingsEntity>
    {
        public SettingsController(ISettingsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }

        public override HttpResponseMessage Post([FromBody] SettingsCreator creator)
        {
            throw new NotImplementedException();
        }
    }
}