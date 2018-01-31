using MouseApi.Entities;
using MouseApi.Shared;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.BreedingMale
{
    public class BreedingMaleFilterProvider : BaseFilterProvider<BreedingMaleEntity>, IBreedingMaleFilterProvider
    {
        public override IEnumerable<BreedingMaleEntity> Filter(IEnumerable<BreedingMaleEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "currentCageId":
                        list = list.Where(x => x.CurrentCageId == filter.Value);
                        break;
                    case "active":
                        list = list.Where(x => x.Active == Int32.Parse(filter.Value));
                        break;
                    case "orderByDate":
                        if (filter.Value == MouseApiConstants.ASCENDING_QUERY_STRING_VALUE)
                            list = list.OrderBy(x => x.DOB);
                        if (filter.Value == MouseApiConstants.DESCENDING_QUERY_STRING_VALUE)
                            list = list.OrderByDescending(x => x.DOB);
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}