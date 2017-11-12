using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Cages
{
    public class BreedingCagePatcher : BasePatcher<BreedingCageEntity>, IBreedingCagePatcher
    {
        public override BreedingCageEntity Patch(BreedingCageEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach(var property in patchedProperties)
            {
                switch(property.Key)
                {
                    case "row":
                        oldEntity.GenericCage.Row = Int32.Parse(property.Value);
                        break;
                    case "column":
                        oldEntity.GenericCage.Column = Int32.Parse(property.Value);
                        break;
                    case "rack":
                        oldEntity.GenericCage.Rack = Int32.Parse(property.Value);
                        break;
                    case "active":
                        oldEntity.GenericCage.Active = Int32.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}