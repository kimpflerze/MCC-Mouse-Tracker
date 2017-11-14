using MouseApi.Entities;
using MouseApi.FilterProviders.Settings;
using MouseApi.Patchers.Settings;
using MouseApi.Validator.Settings;
using MouseApi.DataAccess;

namespace MouseApi.Service.Settings
{
    public class SettingsService : BaseService<SettingsEntity, ISettingsValidator, ISettingsFilterProvider, ISettingsPatcher>, ISettingsService
    {
        public SettingsService(MouseTrackDbContext dbContext
            , IBaseRepository<SettingsEntity> respository
            , ISettingsValidator validator
            , ISettingsFilterProvider provider
            , ISettingsPatcher patcher) : base(dbContext, respository, validator, provider, patcher)
        {
        }
    }
}