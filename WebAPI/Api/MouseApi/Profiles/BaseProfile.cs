using AutoMapper;
using MouseApi.Entities;
using System;

namespace MouseApi.Profiles
{
    public abstract class BaseProfile<TCreate, TModel, TEntity> : Profile where TEntity : BaseEntity, new()
    {
        public BaseProfile()
        {
            CreateMap<TCreate, TEntity>().ConstructUsing(MappingFunc);
            CreateMap<TModel, TEntity>().ReverseMap();
        }

        protected virtual TEntity MappingFunc(TCreate creator)
        {
            return new TEntity
            {
                Id = Guid.NewGuid().ToString("N")
            };
        }
    }
}