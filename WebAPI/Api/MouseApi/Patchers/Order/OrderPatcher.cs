using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Order
{
    public class OrderPatcher : BasePatcher<OrderEntity>, IOrderPatcher
    {
        public override OrderEntity Patch(OrderEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}