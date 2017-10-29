using MouseApi.DataAccess;
using MouseApi.Entities;
using MouseApi.FilterProviders;
using MouseApi.FilterProviders.Cages;
using MouseApi.Validator.Cages;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.Service.Cages
{
    public class BreedingCageService : BaseService<BreedingCageEntity, BreedingCageValidator, IBreedingCageFilterProvider>, IBreedingCageService
    {
        protected IBaseRepository<GenericCageEntity> _genericCageRepository;
        protected IBaseRepository<ParentCageLookupEntity> _lookupRepository;
        protected IBaseRepository<BreedingMaleEntity> _breedingMaleRepository;
        protected IBaseRepository<LitterLogEntity> _litterLogRepository;

        public BreedingCageService(MouseTrackDbContext dbContext
            , IBaseRepository<BreedingCageEntity> repository
            , IBaseRepository<GenericCageEntity> genericCageRepository
            , IBaseRepository<ParentCageLookupEntity> lookupRepository
            , IBaseRepository<BreedingMaleEntity> breedingMaleRepository
            , BreedingCageValidator validator
            , IBreedingCageFilterProvider provider) : base(dbContext, repository, validator, provider)
        {
            _genericCageRepository = genericCageRepository;
            _lookupRepository = lookupRepository;
            _breedingMaleRepository = breedingMaleRepository;
        }

        public override IEnumerable<BreedingCageEntity> Get(IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            ////foreach(var queryParam in queryParams)
            ////{
            ////    if(queryParam.Key.Equals("active"))
            ////    {
            ////        return base.Get(queryParams).Where(x => x.GenericCage.Active.Equals(Int32.Parse(queryParam.Value)));
            ////    }
            ////}
            //if(queryParams.Count() > 0)
            //{
            //    return BreedingCageFilterProvider.Filter(base.Get(queryParams), queryParams);
            //}
            return base.Get(queryParams);
        }

        /// <summary>
        /// Overrides basic Add funcitonality. Links Breeding Cage with Generic Cage
        /// and with its Parent Cages
        /// </summary>
        /// <param name="entity">The <see cref="BreedingCageEntity"/> being added.</param>
        /// <returns>The <see cref="BreedingCageEntity"/>that was added.</returns>
        public override BreedingCageEntity Add(BreedingCageEntity entity)
        {
            foreach(var parentCage in entity.GenericCage.ParentCages)
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
        public override BreedingCageEntity Update(BreedingCageEntity entity)
        {
            foreach(var parentCage in entity.GenericCage.ParentCages)
            {
                _lookupRepository.Update(parentCage);
            }
            _genericCageRepository.Update(entity.GenericCage);
            return base.Update(entity);
        }
    }
}