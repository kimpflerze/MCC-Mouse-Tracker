using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Cages
{
    public class GenericCageValidator : AbstractValidator<GenericCageEntity>, IGenericCageValidator
    {
        public GenericCageValidator()
        {           
        }
    }
}