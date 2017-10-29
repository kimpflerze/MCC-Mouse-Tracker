using MouseApi.DataAccess;
using MouseApi.Entities;

namespace MouseApi.Service.Sample
{
    public class SampleService : BaseService<SampleEntity>, ISampleService
    {
        public SampleService(MouseTrackDbContext dbContext) : base(dbContext)
        {
        }
    }
}