using MouseApi.Entities;
using System.Collections.Generic;

namespace MouseApi.Patchers.ParentCageLookup
{
    public class ParentCageLookupPatcher : BasePatcher<ParentCageLookupEntity>, IParentCageLookupPatcher
    {
        public override ParentCageLookupEntity Patch(ParentCageLookupEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
                {
                    case "currentCageId":
                        oldEntity.CurrentCageId = property.Value;
                        break;
                }
            }
            return oldEntity;
        }
    }
}