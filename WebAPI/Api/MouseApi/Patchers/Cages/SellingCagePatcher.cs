using System.Collections.Generic;
using MouseApi.Entities;
using System;

namespace MouseApi.Patchers.Cages
{
    public class SellingCagePatcher : BasePatcher<SellingCageEntity>, ISellingCagePatcher
    {
        public override SellingCageEntity Patch(SellingCageEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
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
                    case "numberOfMice":
                        oldEntity.NumberOfMice = Int32.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}