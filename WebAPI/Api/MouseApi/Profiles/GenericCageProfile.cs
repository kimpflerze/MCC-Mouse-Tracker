using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the GenericCage resource.
    /// </summary>
    public class GenericCageProfile : BaseProfile<GenericCageCreator, GenericCageModel, GenericCageEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="GenericCageProfile"/>.
        /// </summary>
        public GenericCageProfile() : base()
        {
        }

        /// <summary>
        /// Overrides the base mapping function from <see cref="GenericCageCreator"/> to <see cref="GenericCageEntity"/>.
        /// </summary>
        /// <param name="creator">The <see cref="GenericCageCreator"/>to map from.</param>
        /// <returns>A <see cref="GenericCageEntity"/>mapped from the given <see cref="GenericCageCreator"/>.</returns>
        protected override GenericCageEntity MappingFunc(GenericCageCreator creator)
        {
            var entity = base.MappingFunc(creator);
            entity.Created = DateTime.Now;
            return entity;
        }
    }
}