using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Profiles
{
    public class GenericCageProfile : BaseProfile<GenericCageCreator, GenericCageModel, GenericCageEntity>
    {
        public GenericCageProfile() : base()
        {
        }

        protected override GenericCageEntity MappingFunc(GenericCageCreator creator)
        {
            var entity = base.MappingFunc(creator);
            entity.Created = DateTime.Now;
            return entity;
        }
    }
}