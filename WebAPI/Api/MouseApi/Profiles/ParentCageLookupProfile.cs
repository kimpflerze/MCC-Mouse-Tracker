using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Profiles
{
    public class ParentCageLookupProfile : BaseProfile<ParentCageLookupCreator, ParentCageLookupModel, ParentCageLookupEntity>
    {
        public ParentCageLookupProfile() : base()
        {
        }
    }
}