using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Settings
{
    /// <summary>
    /// Validator for <see cref="SettingsEntity"/>.
    /// </summary>
    public class SettingsValidator : AbstractValidator<SettingsEntity>, ISettingsValidator
    {
        /// <summary>
        /// Creates a new instance of <see cref="SettingsValidator"/>.
        /// </summary>
        public SettingsValidator()
        {
            RuleFor(settings => settings.Rows).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.Rows)}");
            RuleFor(settings => settings.Columns).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.Columns)}");
            RuleFor(settings => settings.Racks).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.Racks)}");
            RuleFor(settings => settings.WeaningPeriod).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.WeaningPeriod)}");
            RuleFor(settings => settings.GestationPeriod).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.GestationPeriod)}");
            RuleFor(settings => settings.BreedingPeriod).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.BreedingPeriod)}");
            RuleFor(settings => settings.MaleLifespan).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.MaleLifespan)}");
            RuleFor(settings => settings.FemaleLifespan).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.FemaleLifespan)}");
            RuleFor(settings => settings.MaleLifespan).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.MaleLifespan)}");
            RuleFor(settings => settings.FemaleCost).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.FemaleCost)}");
            RuleFor(settings => settings.MaleCost).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.MaleCost)}");
            RuleFor(settings => settings.CageCost).GreaterThan(0).WithMessage($"Invalid property: {nameof(SettingsEntity.CageCost)}");
        }
    }
}