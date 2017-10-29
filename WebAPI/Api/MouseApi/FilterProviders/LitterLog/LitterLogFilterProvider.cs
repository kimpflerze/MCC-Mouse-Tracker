using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.FilterProviders.LitterLog
{
    public class LitterLogFilterProvider : BaseFilterProvider<LitterLogEntity>, ILitterLogFilterProvider
    {
        public override IEnumerable<LitterLogEntity> Filter(IEnumerable<LitterLogEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            return list;
        }
    }
}