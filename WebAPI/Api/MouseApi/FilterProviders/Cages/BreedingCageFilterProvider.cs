using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.Cages
{
    public class BreedingCageFilterProvider : BaseFilterProvider<BreedingCageEntity>, IBreedingCageFilterProvider
    {
        public override IEnumerable<BreedingCageEntity> Filter(IEnumerable<BreedingCageEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach(var filter in queryParams)
            {
                switch(filter.Key)
                {
                    case "active":
                        list = list.Where(x => x.GenericCage.Active == Int32.Parse(filter.Value));
                        break;
                    case "row":
                        list = list.Where(x => x.GenericCage.Row == Int32.Parse(filter.Value));
                        break;
                    case "column":
                        list = list.Where(x => x.GenericCage.Column == Int32.Parse(filter.Value));
                        break;
                    case "rack":
                        list = list.Where(x => x.GenericCage.Rack == Int32.Parse(filter.Value));
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}