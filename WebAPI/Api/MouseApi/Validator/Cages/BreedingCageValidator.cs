using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Cages
{
    public class BreedingCageValidator : BaseValidator<BreedingCageEntity>
    {
        public BreedingCageValidator()
        {
            RuleFor(cage => cage.GenericCage.Row).NotEqual(0).WithMessage("Invalid Row Number").NotNull().WithMessage("Missing Property: Row");
            RuleFor(cage => cage.GenericCage.Column).NotEqual(0).WithMessage("Invalid Column Number").NotNull().WithMessage("Missing Property: Column");
            RuleFor(cage => cage.GenericCage.Column).NotEqual(0).WithMessage("Invalid Rack Number").NotNull().WithMessage("Missing Property: Column");
            RuleFor(cage => cage.GenericCage.Active).NotNull().WithMessage($"Missing property: {nameof(GenericCageEntity.Active)}");
        }
    }
}