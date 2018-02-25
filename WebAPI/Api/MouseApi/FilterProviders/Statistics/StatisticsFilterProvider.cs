using MouseApi.Entities;
using MouseApi.Shared;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.Statistics
{
    public class StatisticsFilterProvider : BaseFilterProvider<StatisticsEntity>, IStatisticsFilterProvider
    {
        public override IEnumerable<StatisticsEntity> Filter(IEnumerable<StatisticsEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            throw new NotImplementedException();
            //foreach (var filter in queryParams)
            //{
            //    switch (filter.Key)
            //    {
            //        case "orderByDate":
            //            if (filter.Value == MouseApiConstants.ASCENDING_QUERY_STRING_VALUE)
            //                list = list.OrderBy(x => x.Date);
            //            if (filter.Value == MouseApiConstants.DESCENDING_QUERY_STRING_VALUE)
            //                list = list.OrderByDescending(x => x.Date);
            //            break;
            //        default:
            //            break;
            //    }
            //}
            //return list;
        }
    }
}