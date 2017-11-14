using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Cages
{
    /// <summary>
    /// Validator for <see cref="BreedingCageEntity"/>.
    /// </summary>
    public class BreedingCageValidator : AbstractValidator<BreedingCageEntity>, IBreedingCageValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="BreedingCageValidator"/>.
        /// </summary>
        public BreedingCageValidator()
        {
            RuleFor(cage => cage.Id).NotNull().WithMessage($"Missing property: {nameof(BreedingCageEntity.Id)}");
            RuleFor(cage => cage.GenericCage.Row).GreaterThan(0).WithMessage("Invalid Row Number");
            RuleFor(cage => cage.GenericCage.Column).GreaterThan(0).WithMessage("Invalid Column Number");
            RuleFor(cage => cage.GenericCage.Rack).GreaterThan(0).WithMessage("Invalid Rack Number");
            RuleFor(cage => cage.GenericCage.Active).InclusiveBetween(0, 1).WithMessage("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}