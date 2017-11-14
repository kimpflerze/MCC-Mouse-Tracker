using MouseApi.Entities;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Settings
{
    public class SettingsPatcher : BasePatcher<SettingsEntity>, ISettingsPatcher
    {
        public override SettingsEntity Patch(SettingsEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}