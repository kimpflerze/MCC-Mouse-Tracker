using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Profiles
{
    public class BreedingCageProfile : BaseProfile<BreedingCageCreator, BreedingCageModel, BreedingCageEntity>
    {
        public BreedingCageProfile() : base()
        {
        }
    }
}