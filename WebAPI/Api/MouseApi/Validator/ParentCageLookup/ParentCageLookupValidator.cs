using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.ParentCageLookup
{
    public class ParentCageLookupValidator : BaseValidator<ParentCageLookupEntity>, IParentCageLookupValidator
    {
    }
}