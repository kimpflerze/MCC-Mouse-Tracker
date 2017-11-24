using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Cages
{
    /// <summary>
    /// Validator for <see cref="SellingCageEntity"/>.
    /// </summary>
    public class SellingCageValidator : AbstractValidator<SellingCageEntity>, ISellingCageValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="SellingCageValidator"/>.
        /// </summary>
        public SellingCageValidator()
        {
            RuleFor(cage => cage.Id).NotNull().WithMessage($"Missing property: {nameof(SellingCageEntity.Id)}");
            RuleFor(cage => cage.GenericCage.Row).NotEqual(0).WithMessage("Invalid Row Number").NotNull().WithMessage("Missing Property: Row");
            RuleFor(cage => cage.GenericCage.Column).NotEqual(0).WithMessage("Invalid Column Number").NotNull().WithMessage("Missing Property: Column");
            RuleFor(cage => cage.GenericCage.Rack).NotEqual(0).WithMessage("Invalid Rack Number").NotNull().WithMessage("Missing Property: Column");
            RuleFor(cage => cage.Gender).InclusiveBetween(0, 1).WithMessage("Gender must be either 0 (female) or 1 (male)");
            RuleFor(cage => cage.NumberOfMice).GreaterThan(0).WithMessage("Invalid Number of Mice");
            RuleFor(cage => cage.GenericCage.Active).InclusiveBetween(0, 1).WithMessage("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}