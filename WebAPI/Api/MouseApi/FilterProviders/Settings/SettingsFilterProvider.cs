using System.Collections.Generic;
using MouseApi.Entities;

namespace MouseApi.FilterProviders.Settings
{
    public class SettingsFilterProvider : BaseFilterProvider<SettingsEntity>, ISettingsFilterProvider
    {
        public override IEnumerable<SettingsEntity> Filter(IEnumerable<SettingsEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            throw new System.NotImplementedException();
        }
    }
}