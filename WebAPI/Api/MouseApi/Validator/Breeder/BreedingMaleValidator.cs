using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Breeder
{
    public class BreedingMaleValidator : AbstractValidator<BreedingMaleEntity>, IBreedingMaleValidator
    {
        public BreedingMaleValidator()
        {
            RuleFor(cage => cage.Id).NotNull().WithMessage("Id cannot be null");
            RuleFor(male => male.CurrentCageId).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.CurrentCageId)}");
            RuleFor(male => male.DOB).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.DOB)}");
            RuleFor(male => male.MotherCageId).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.MotherCageId)}");
            RuleFor(cage => cage.Active).InclusiveBetween(0, 1).WithMessage("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}