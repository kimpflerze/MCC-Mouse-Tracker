using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Order
{
    public class OrderPatcher : BasePatcher<OrderEntity>, IOrderPatcher
    {
        public override OrderEntity Patch(OrderEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
                {
                    case "charged":
                        oldEntity.Charged = Int32.Parse(property.Value);
                        break;
                    case "active":
                        oldEntity.Active = Int32.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}