using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.ParentCageLookup
{
    /// <summary>
    /// Validator for <see cref="ParentCageLookupEntity"/>.
    /// </summary>
    public class ParentCageLookupValidator : AbstractValidator<ParentCageLookupEntity>, IParentCageLookupValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="ParentCageLookupValidator"/>.
        /// </summary>
        public ParentCageLookupValidator()
        {
            RuleFor(parent => parent.CurrentCageId).NotNull().WithMessage($"Missing property: {nameof(ParentCageLookupEntity.CurrentCageId)}");
            RuleFor(parent => parent.ParentCageId).NotNull().WithMessage($"Missing property: {nameof(ParentCageLookupEntity.ParentCageId)}");
        }
    }
}