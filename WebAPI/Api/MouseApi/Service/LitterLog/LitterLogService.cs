using FluentValidation;
using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.LitterLog;
using MouseApi.Patchers.LitterLog;
using MouseApi.Validator.LitterLog;
using System;
using System.Linq;

namespace MouseApi.Service.LitterLog
{
    public class LitterLogService : BaseService<LitterLogEntity, ILitterLogValidator, ILitterLogFilterProvider, ILitterLogPatcher>, ILitterLogService
    {
        private IBaseRepository<BreedingCageEntity> _breedingCageRepository;
        private IBaseRepository<BreedingMaleEntity> _breedingMaleRepository;

        public LitterLogService(MouseTrackDbContext dbContext
            , IBaseRepository<LitterLogEntity> repository
            , IBaseRepository<BreedingCageEntity> breedingCageRepository
            , IBaseRepository<BreedingMaleEntity> breedingMaleRespository
            , ILitterLogValidator validator
            , ILitterLogFilterProvider provider
            , ILitterLogPatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
            _breedingCageRepository = breedingCageRepository;
            _breedingMaleRepository = breedingMaleRespository;
        }

        public override LitterLogEntity Add(LitterLogEntity entity)
        {
            entity.DOB = DateTime.Now;

            var breedingCage = _breedingCageRepository.Find(entity.MotherCageId);
            var maleInCage = _breedingMaleRepository.Get().Where(x => x.CurrentCageId == breedingCage.Id && x.Active != 0).FirstOrDefault();

            if (maleInCage == null) throw new ValidationException("The provided cage contains no Breeding Male");

            entity.FatherId = maleInCage.Id;

            breedingCage.LitterDOB = entity.DOB;
            breedingCage.LittersFromCage++;
            _breedingCageRepository.Update(breedingCage);
            return base.Add(entity);   
        }
    }
}