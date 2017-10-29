using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.FilterProviders.Cages
{
    public class GenericCageFilterProvider : BaseFilterProvider<GenericCageEntity>, IGenericCageFilterProvider
    {
        public override IEnumerable<GenericCageEntity> Filter(IEnumerable<GenericCageEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            return list;
        }
    }
}