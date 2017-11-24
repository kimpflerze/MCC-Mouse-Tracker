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
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "currentCageId":
                        list = list.Where(x => x.CurrentCageId == filter.Value);
                        break;
                    case "parentCageId":
                        list = list.Where(x => x.ParentCageId == filter.Value);
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}