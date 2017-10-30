using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.FilterProviders.ParentCageLookup
{
    public class ParentCageLookupFilterProvider : BaseFilterProvider<ParentCageLookupEntity>, IParentCageLookupFilterProvider
    {
        public override IEnumerable<ParentCageLookupEntity> Filter(IEnumerable<ParentCageLookupEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            return list;
        }
    }
}