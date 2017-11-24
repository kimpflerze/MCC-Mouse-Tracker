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
                    case "motherCageId":
                        list = list.Where(x => x.MotherCageId == filter.Value);
                        break;
                    case "fatherId":
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