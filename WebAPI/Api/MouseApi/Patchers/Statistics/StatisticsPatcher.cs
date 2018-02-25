using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Statistics
{
    public class StatisticsPatcher : BasePatcher<StatisticsEntity>, IStatisticsPatcher
    {
        public override StatisticsEntity Patch(StatisticsEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}