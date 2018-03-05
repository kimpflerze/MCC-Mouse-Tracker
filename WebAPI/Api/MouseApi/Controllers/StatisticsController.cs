using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Statistics;
using MouseApi.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Net.Http;

namespace MouseApi.Controllers
{
    public class StatisticsController : BaseController<IStatisticsService, StatisticsCreator, StatisticsModel, StatisticsEntity>
    {
        public StatisticsController(IStatisticsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }

        [Route("api/statistics/current")]
        [HttpGet]
        public StatisticsModel GetToday()
        {
            return _mapper.Map<StatisticsModel>(_service.Get().First());
        }

        public override HttpResponseMessage Post([FromBody] StatisticsCreator creator)
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<StatisticsModel> Get()
        {
            throw new NotImplementedException();
        }

        public override HttpResponseMessage Patch(string id)
        {
            throw new NotImplementedException();
        }

        public override HttpResponseMessage Put([FromBody] StatisticsCreator entity)
        {
            throw new NotImplementedException();
        }

        public override HttpResponseMessage Get(string id)
        {
            throw new NotImplementedException();
        }
    }
}