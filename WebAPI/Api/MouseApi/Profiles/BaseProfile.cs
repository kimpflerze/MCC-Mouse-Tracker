using AutoMapper;
using MouseApi.Entities;
using System;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Abstract base mapping profile for all resources.
    /// </summary>
    /// <typeparam name="TCreate">The Creator associated with the resource.</typeparam>
    /// <typeparam name="TModel">The View Model associated with the resource.</typeparam>
    /// <typeparam name="TEntity">The Entity associated with the resource.</typeparam>
    public abstract class BaseProfile<TCreate, TModel, TEntity> : Profile where TEntity : BaseEntity, new()
    {
        /// <summary>
        /// Constructs a new instance of <see cref="BaseProfile{TCreate, TModel, TEntity}"/>.
        /// </summary>
        public BaseProfile()
        {
            CreateMap<TCreate, TEntity>().ConstructUsing(MappingFunc);
            CreateMap<TModel, TEntity>().ReverseMap();
        }

        /// <summary>
        /// Custom mapping function from <see cref="TCreate"/> to <see cref="TEntity"/>.
        /// </summary>
        /// <param name="creator">The <see cref="TCreate"/></param>to map from.
        /// <returns>A <see cref="TEntity"/>mapped from the given <see cref="TCreate"/>.</returns>
        protected virtual TEntity MappingFunc(TCreate creator)
        {
            return new TEntity
            {
                Id = Guid.NewGuid().ToString("N")
            };
        }
    }
}