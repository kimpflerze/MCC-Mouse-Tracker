using System.Net.Http;
using System.Web.Http;
using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Settings;
using MouseApi.ViewModels;
using System;
using System.Net;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for the settings/ endpoint.
    /// </summary>
    public class SettingsController : BaseController<ISettingsService, SettingsCreator, SettingsModel, SettingsEntity>
    {
        /// <summary>
        /// Creates a new instanc of <see cref="SettingsController"/>.
        /// </summary>
        /// <param name="service">The <see cref="ISettingsService"/>that will process the requests.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping between models.</param>
        public SettingsController(ISettingsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }

        public override HttpResponseMessage Post([FromBody] SettingsCreator creator)
        {
            throw new NotImplementedException();
        }

        public override HttpResponseMessage Put([FromBody] SettingsCreator entity)
        {
            var response = _service.Update(_mapper.Map<SettingsEntity>(entity));
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}