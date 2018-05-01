using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Alert
{
    public class AlertPatcher : BasePatcher<AlertEntity>, IAlertPatcher
    {
        public override AlertEntity Patch(AlertEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
                {
                    case "resolved":
                        oldEntity.Resolved = Int32.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}