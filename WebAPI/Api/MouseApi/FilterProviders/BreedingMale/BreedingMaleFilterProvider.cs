﻿using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
                    case "active":
                        list = list.Where(x => x.Active == Int32.Parse(filter.Value));
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}