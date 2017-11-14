using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Settings
{
    public class SettingsValidator : AbstractValidator<SettingsEntity>, ISettingsValidator
    {
    }
}