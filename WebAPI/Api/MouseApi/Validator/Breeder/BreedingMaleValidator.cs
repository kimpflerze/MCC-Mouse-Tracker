using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Breeder
{
    public class BreedingMaleValidator : BaseValidator<BreedingMaleEntity>, IBreedingMaleValidator
    {
        public BreedingMaleValidator()
        {
            RuleFor(cage => cage.Active).InclusiveBetween(0, 1).WithMessage("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}