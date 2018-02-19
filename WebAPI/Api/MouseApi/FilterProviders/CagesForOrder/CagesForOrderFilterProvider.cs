using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.FilterProviders.CagesForOrder
{
    public class CagesForOrderFilterProvider : BaseFilterProvider<CagesForOrderEntity>, ICagesForOrderFilterProvider
    {
        public override IEnumerable<CagesForOrderEntity> Filter(IEnumerable<CagesForOrderEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            throw new NotImplementedException();
        }
    }
}