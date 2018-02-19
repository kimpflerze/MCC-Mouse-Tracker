using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.CagesForOrder
{
    public class CagesForOrderPatcher : BasePatcher<CagesForOrderEntity>, ICagesForOrderPatcher
    {
        public override CagesForOrderEntity Patch(CagesForOrderEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}