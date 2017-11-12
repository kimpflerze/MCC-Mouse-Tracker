using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Cages
{
    public class GenericCagePatcher : BasePatcher<GenericCageEntity>, IGenericCagePatcher
    {
        public override GenericCageEntity Patch(GenericCageEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}