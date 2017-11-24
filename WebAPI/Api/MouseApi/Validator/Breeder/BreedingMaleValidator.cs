using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Breeder
{
    /// <summary>
    /// Validator for <see cref="BreedingMaleEntity"/>.
    /// </summary>
    public class BreedingMaleValidator : AbstractValidator<BreedingMaleEntity>, IBreedingMaleValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="BreedingMaleValidator"/>.
        /// </summary>
        public BreedingMaleValidator()
        {
            RuleFor(cage => cage.Id).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.Id)}");
            RuleFor(male => male.CurrentCageId).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.CurrentCageId)}");
            RuleFor(male => male.MotherCageId).NotNull().WithMessage($"Missing property: {nameof(BreedingMaleEntity.MotherCageId)}");
            RuleFor(cage => cage.Active).InclusiveBetween(0, 1).WithMessage("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}