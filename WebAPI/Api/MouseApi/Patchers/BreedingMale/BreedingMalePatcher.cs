using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.BreedingMale
{
    public class BreedingMalePatcher : BasePatcher<BreedingMaleEntity>, IBreedingMalePatcher
    {
        public override BreedingMaleEntity Patch(BreedingMaleEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
                {
                    case "currentCageId":
                        oldEntity.CurrentCageId = property.Value;
                        break;
                    case "active":
                        oldEntity.Active = Int32.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}