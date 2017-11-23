using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Alert
{
    /// <summary>
    /// Validator for <see cref="AlertEntity"/>.
    /// </summary>
    public class AlertValidator : AbstractValidator<AlertEntity>, IAlertValidator
    {
    }
}