using FluentValidation;
using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.BreedingMale;
using MouseApi.Patchers.BreedingMale;
using MouseApi.Validator.Breeder;
using System;

namespace MouseApi.Service.Breeder
{
    /// <summary>
    /// Service for <see cref="BreedingMaleEntity"/>.
    /// </summary>
    public class BreedingMaleService : BaseService<BreedingMaleEntity, IBreedingMaleValidator, IBreedingMaleFilterProvider, IBreedingMalePatcher>, IBreedingMaleService
    {
        private IBaseRepository<BreedingCageEntity> _breedingCageRepository;

        /// <summary>
        /// Creates a new instance of <see cref="BreedingMaleService"/>.
        /// </summary>
        /// <param name="dbContext">The <see cref="MouseTrackDbContext"/>used.</param>
        /// <param name="repository">The <see cref="IBaseRepository{BreedingMaleEntity}"/>used to interact with Breeding Males in the DB.</param>
        /// <param name="breedingCageRepository">The <see cref="IBaseRepository{BreedingCageEntity}"/>used to interact with Breeding Cages in the DB.</param>
        /// <param name="validator">The <see cref="IBreedingMaleValidator"/>used for entity validation.</param>
        /// <param name="provider">The <see cref="IBreedingMaleFilterProvider"/>used to provide query filters.</param>
        /// <param name="patcher">The <see cref="IBreedingMalePatcher"/>used to patch entities.</param>
        public BreedingMaleService(MouseTrackDbContext dbContext
            , IBaseRepository<BreedingMaleEntity> repository
            , IBaseRepository<BreedingCageEntity> breedingCageRepository
            , IBreedingMaleValidator validator
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
                if (SiblingCheck(entity, breedingCage)) throw new ValidationException("These are siblings!");
            }
            return base.Add(entity);
        }

        public override BreedingMaleEntity Update(BreedingMaleEntity entity)
        {
            var breedingCage = _breedingCageRepository.Find(entity.CurrentCageId);
            if (SiblingCheck(entity, breedingCage)) throw new ValidationException("These are siblings!");
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