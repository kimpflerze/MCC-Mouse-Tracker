using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Settings
{
    public class SettingsPatcher : BasePatcher<SettingsEntity>, ISettingsPatcher
    {
        public override SettingsEntity Patch(SettingsEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            foreach (var property in patchedProperties)
            {
                switch (property.Key)
                {
                    case "rows":
                        oldEntity.Rows = Int32.Parse(property.Value);
                        break;
                    case "columns":
                        oldEntity.Columns = Int32.Parse(property.Value);
                        break;
                    case "racks":
                        oldEntity.Racks = Int32.Parse(property.Value);
                        break;
                    case "weaningPeriod":
                        oldEntity.WeaningPeriod = Int32.Parse(property.Value);
                        break;
                    case "breedingPeriod":
                        oldEntity.BreedingPeriod = Int32.Parse(property.Value);
                        break;
                    case "gestationPeriod":
                        oldEntity.GestationPeriod = Int32.Parse(property.Value);
                        break;
                    case "maleLifespan":
                        oldEntity.MaleLifespan = Int32.Parse(property.Value);
                        break;
                    case "femaleLifespan":
                        oldEntity.FemaleLifespan = Int32.Parse(property.Value);
                        break;
                    case "maleCost":
                        oldEntity.MaleCost = Decimal.Parse(property.Value);
                        break;
                    case "femaleCost":
                        oldEntity.FemaleCost = Decimal.Parse(property.Value);
                        break;
                    case "cageCost":
                        oldEntity.CageCost = Decimal.Parse(property.Value);
                        break;
                }
            }
            return oldEntity;
        }
    }
}