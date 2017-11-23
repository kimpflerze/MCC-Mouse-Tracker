using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.LitterLog
{
    public class LitterLogPatcher : BasePatcher<LitterLogEntity>, ILitterLogPatcher
    {
        public override LitterLogEntity Patch(LitterLogEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}