using MouseApi.Creators;
using MouseApi.Entities.Transaction;
using MouseApi.ViewModels;
using System;

namespace MouseApi.Profiles
{
    public class TransactionProfile : BaseProfile<TransactionCreator, TransactionModel, TransactionEntity>
    {
        public TransactionProfile()
        {
            CreateMap<TransactionCreator, TransactionEntity>().ConstructUsing(MappingFunc);
            CreateMap<TransactionEntity, TransactionModel>()
                .ForMember(dest => dest.Event, x => x.MapFrom(entity => entity.Event.EventDescription))
                .ForMember(model => model.Object, x => x.MapFrom(entity => entity.Object.ObjectDescription));
        }

        protected override TransactionEntity MappingFunc(TransactionCreator creator)
        {
            var entity = base.MappingFunc(creator);
            entity.TransactionDate = DateTime.Now;
            return entity;
        }
    }
}