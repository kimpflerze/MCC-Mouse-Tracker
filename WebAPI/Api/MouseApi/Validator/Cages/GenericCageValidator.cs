using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Cages
{
    /// <summary>
    /// Validator for <see cref="GenericCageEntity"/>.
    /// </summary>
    public class GenericCageValidator : AbstractValidator<GenericCageEntity>, IGenericCageValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="GenericCageValidator"/>.
        /// </summary>
        public GenericCageValidator()
        {           
        }
    }
}