using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.CagesForOrder
{
    public class CagesForOrderValidator : AbstractValidator<CagesForOrderEntity>, ICagesForOrderValidator
    {
        public CagesForOrderValidator()
        {

        }
    }
}