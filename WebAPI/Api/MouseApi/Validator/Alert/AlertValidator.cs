using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Alert
{
    public class AlertValidator : AbstractValidator<AlertEntity>, IAlertValidator
    {
    }
}