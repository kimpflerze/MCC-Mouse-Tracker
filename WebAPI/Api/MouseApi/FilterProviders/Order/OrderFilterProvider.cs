using MouseApi.Entities;
using MouseApi.Shared;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.Order
{
    public class OrderFilterProvider : BaseFilterProvider<OrderEntity>, IOrderFilterProvider
    {
        public override IEnumerable<OrderEntity> Filter(IEnumerable<OrderEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "active":
                        list = list.Where(x => x.Active == Int32.Parse(filter.Value));
                        break;
                    case "orderByDate":
                        if (filter.Value == MouseApiConstants.ASCENDING_QUERY_STRING_VALUE)
                            list = list.OrderBy(x => x.DeliveryDate);
                        if (filter.Value == MouseApiConstants.DESCENDING_QUERY_STRING_VALUE)
                            list = list.OrderByDescending(x => x.DeliveryDate);
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}