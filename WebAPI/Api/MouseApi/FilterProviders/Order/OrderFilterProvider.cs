using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.FilterProviders.Order
{
    public class OrderFilterProvider : BaseFilterProvider<OrderEntity>, IOrderFilterProvider
    {
        public override IEnumerable<OrderEntity> Filter(IEnumerable<OrderEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            throw new NotImplementedException();
        }
    }
}