using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.LitterLog
{
    public class LitterLogValidator : AbstractValidator<LitterLogEntity>, ILitterLogValidator
    {
    }
}