using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Alert
{
    public class AlertPatcher : BasePatcher<AlertEntity>, IAlertPatcher
    {
        public override AlertEntity Patch(AlertEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}