using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.BreedingMale;
using MouseApi.Patchers.BreedingMale;
using MouseApi.Validator.Breeder;
using System;

namespace MouseApi.Service.Breeder
{
    public class BreedingMaleService : BaseService<BreedingMaleEntity, BreedingMaleValidator, IBreedingMaleFilterProvider, IBreedingMalePatcher>, IBreedingMaleService
    {
        private IBaseRepository<BreedingCageEntity> _breedingCageRepository;
        public BreedingMaleService(MouseTrackDbContext dbContext
            , IBaseRepository<BreedingMaleEntity> repository
            , IBaseRepository<BreedingCageEntity> breedingCageRepository
            , BreedingMaleValidator validator
            , IBreedingMaleFilterProvider provider
            , IBreedingMalePatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
            _breedingCageRepository = breedingCageRepository;
        }

        /// <summary>
        /// Overrides the basic Add functionality. Performs inbreeding checks before adding.
        /// </summary>
        /// <param name="entity">The <see cref="BreedingMaleEntity"/>being added.</param>
        /// <returns>The added <see cref="BreedingMaleEntity"/>.</returns>
        public override BreedingMaleEntity Add(BreedingMaleEntity entity)
        {
            if(entity.Active != 0)
            {
                var breedingCage = _breedingCageRepository.Find(entity.CurrentCageId);
                if (SiblingCheck(entity, breedingCage)) throw new Exception("These are siblings!");
            }
            return base.Add(entity);
        }

        public override BreedingMaleEntity Update(BreedingMaleEntity entity)
        {
            var breedingCage = _breedingCageRepository.Find(entity.CurrentCageId);
            if (SiblingCheck(entity, breedingCage)) throw new Exception("These are siblings!");
            return base.Update(entity);

        }

        /// <summary>
        /// Checks if the given <see cref="BreedingMaleEntity"/> is a sibling to any 
        /// of the Breeding Females in the given <see cref="BreedingCageEntity"/>.
        /// </summary>
        /// <param name="breedingMale">The <see cref="BreedingMaleEntity"/>.</param>
        /// <param name="breedingCage">The <see cref="BreedingCageEntity"/>.</param>
        /// <returns>true if siblings; false otherwise.</returns>
        private bool SiblingCheck(BreedingMaleEntity breedingMale, BreedingCageEntity breedingCage)
        {
            foreach(var female in breedingCage.GenericCage.ParentCages)
            {
                if(breedingMale.MotherCageId == female.ParentCageId && breedingMale.DOB == female.DOB)
                {
                    return true;
                }
            }
            return false;
        }
    }
}