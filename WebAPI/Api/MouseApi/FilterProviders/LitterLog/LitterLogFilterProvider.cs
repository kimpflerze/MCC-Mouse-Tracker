using MouseApi.Entities;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.LitterLog
{
    public class LitterLogFilterProvider : BaseFilterProvider<LitterLogEntity>, ILitterLogFilterProvider
    {
        public override IEnumerable<LitterLogEntity> Filter(IEnumerable<LitterLogEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "mother":
                        list = list.Where(x => x.MotherId == filter.Value);
                        break;
                    case "father":
                        list = list.Where(x => x.FatherId == filter.Value);
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}