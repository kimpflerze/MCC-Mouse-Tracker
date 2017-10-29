using MouseApi.Entities;
using MouseApi.Service.Sample;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;

namespace MouseApi.Controllers
{
    public class SamplesController : ApiController
    {
        private ISampleService _service;

        public SamplesController(ISampleService service)
        {
            _service = service;
        }

        public IEnumerable<SampleEntity> Get()
        {
            return _service.Get();
        }

        public SampleEntity Get(int id)
        {
            return _service.Find(id);
        }

        public async Task Post([FromBody]SampleEntity entity)
        {
            await _service.AddAsync(entity);
        }

        public SampleEntity Put([FromBody]SampleEntity entity, [FromUri]int id)
        {
            return _service.Update(entity, id);
        }

        public void Delete(int id)
        {
            _service.Delete(id);
        }
    }
}