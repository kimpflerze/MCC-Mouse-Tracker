using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders.Cages;
using MouseApi.Patchers.Cages;
using MouseApi.Validator.Cages;
using System;

namespace MouseApi.Service.Cages
{
    public class SellingCageService : BaseService<SellingCageEntity, ISellingCageValidator, ISellingCageFilterProvider, ISellingCagePatcher>, ISellingCageService
    {
        protected IBaseRepository<GenericCageEntity> _genericCageRepository;
        protected IBaseRepository<ParentCageLookupEntity> _lookupRepository;
        protected IBaseRepository<LitterLogEntity> _litterLogRepository;

        public SellingCageService(MouseTrackDbContext dbContext
            , IBaseRepository<SellingCageEntity> repository
            , IBaseRepository<GenericCageEntity> genericCageRepository
            , IBaseRepository<ParentCageLookupEntity> lookupRepository
            , ISellingCageValidator validator
            , ISellingCageFilterProvider provider
            , ISellingCagePatcher patcher) : base(dbContext, repository, validator, provider, patcher)
        {
            _genericCageRepository = genericCageRepository;
            _lookupRepository = lookupRepository;
        }

        /// <summary>
        /// Overrides basic Add funcitonality. Links Breeding Cage with Generic Cage
        /// and with its Parent Cages
        /// </summary>
        /// <param name="entity">The <see cref="BreedingCageEntity"/> being added.</param>
        /// <returns>The <see cref="BreedingCageEntity"/>that was added.</returns>
        public override SellingCageEntity Add(SellingCageEntity entity)
        {
            foreach (var parentCage in entity.GenericCage.ParentCages)
            {
                parentCage.Id = Guid.NewGuid().ToString("N");
                parentCage.CurrentCageId = entity.Id;
                parentCage.GenericCage = entity.GenericCage;
            }
            return base.Add(entity);
        }

        /// <summary>
        /// Overrides the basic Update functionality. Updates the Breeding Cage, its
        /// corresponding Generic Cage, and its Parent Cage Entries.
        /// </summary>
        /// <param name="entity">The <see cref="BreedingCageEntity"/>being updated.</param>
        /// <param name="keyValues">The key values.</param>
        /// <returns>The Updated <see cref="BreedingCageEntity"/>.</returns>
        public override SellingCageEntity Update(SellingCageEntity entity)
        {
            foreach (var parentCage in entity.GenericCage.ParentCages)
            {
                _lookupRepository.Update(parentCage);
            }
            _genericCageRepository.Update(entity.GenericCage);
            return base.Update(entity);
        }
    }
}