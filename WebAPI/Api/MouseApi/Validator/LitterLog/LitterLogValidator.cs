using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.LitterLog
{
    /// <summary>
    /// Validator for <see cref="LitterLogEntity"/>.
    /// </summary>
    public class LitterLogValidator : AbstractValidator<LitterLogEntity>, ILitterLogValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="LitterLogValidator"/>.
        /// </summary>
        public LitterLogValidator()
        {
            RuleFor(litter => litter.MotherCageId).NotNull().WithMessage($"Missing property: {nameof(LitterLogEntity.MotherCageId)}");
        }
    }
}