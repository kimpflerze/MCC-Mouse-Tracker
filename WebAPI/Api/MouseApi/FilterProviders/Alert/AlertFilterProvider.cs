using MouseApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.Alert
{
    public class AlertFilterProvider : BaseFilterProvider<AlertEntity>, IAlertFilterProvider
    {
        public override IEnumerable<AlertEntity> Filter(IEnumerable<AlertEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "subject":
                        list = list.Where(x => x.SubjectId == filter.Value);
                        break;
                    case "alertType":
                        list = list.Where(x => x.AlertTypeId == Int32.Parse(filter.Value));
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}