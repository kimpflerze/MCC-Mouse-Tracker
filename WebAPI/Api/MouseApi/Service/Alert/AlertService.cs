using System.Collections.Generic;
using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.Alert;
using MouseApi.Patchers.Alert;
using MouseApi.Validator.Alert;

namespace MouseApi.Service.Alert
{
    public class AlertService : BaseService<AlertEntity, IAlertValidator, IAlertFilterProvider, IAlertPatcher>, IAlertService
    {
        private IBaseRepository<BreedingCageEntity> _cageRepository;
        private IBaseRepository<BreedingMaleEntity> _maleRepository;

        public AlertService(MouseTrackDbContext dbContext
            , IBaseRepository<AlertEntity> repository
            , IAlertValidator validator
            , IAlertFilterProvider provider
            , IBaseRepository<BreedingCageEntity> cageRepository
            , IBaseRepository<BreedingMaleEntity> maleRepository
            , IAlertPatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
            _cageRepository = cageRepository;
            _maleRepository = maleRepository;
        }

        public override IEnumerable<AlertEntity> Get(IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            IEnumerable<AlertEntity> entities = base.Get(queryParams);
            foreach (var entity in entities)
            {
                if (entity.AlertTypeId == 1)
                {
                    entity.BreedingCage = _cageRepository.Find(entity.SubjectId);
                }
                else if(entity.AlertTypeId == 2)
                {
                    entity.BreedingMale = _maleRepository.Find(entity.SubjectId);
                }
            }
            return entities;
        }
    }
}