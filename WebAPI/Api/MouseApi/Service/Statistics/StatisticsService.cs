using MouseApi.Entities;
using MouseApi.FilterProviders.Statistics;
using MouseApi.Patchers.Statistics;
using MouseApi.Validator.Statistics;
using MouseApi.DataAccess;

namespace MouseApi.Service.Statistics
{
    public class StatisticsService : BaseService<StatisticsEntity, IStatisticsValidator, IStatisticsFilterProvider, IStatisticsPatcher>, IStatisticsService
    {
        public StatisticsService(MouseTrackDbContext dbContext, 
            IBaseRepository<StatisticsEntity> repository, 
            IStatisticsValidator validator, 
            IStatisticsFilterProvider provider, 
            IStatisticsPatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
        }
    }
}