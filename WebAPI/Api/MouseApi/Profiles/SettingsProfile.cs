using System;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Shared;
using MouseApi.ViewModels;

namespace MouseApi.Profiles
{
    /// <summary>
    /// Mapping profile for the Settings resource.
    /// </summary>
    public class SettingsProfile : BaseProfile<SettingsCreator, SettingsModel, SettingsEntity>
    {
        /// <summary>
        /// Creates a new instance of <see cref="SettingsProfile"/>.
        /// </summary>
        public SettingsProfile()
        {
            CreateMap<SettingsCreator, SettingsEntity>()
                .ForMember(entity => entity.BreedingAlertAdvance, expression => expression.ResolveUsing(creator => MapToDays(creator.BreedingAlertAdvance, creator.BreedingAlertAdvanceUnit)))
                .ForMember(entity => entity.BreedingPeriod, expression => expression.ResolveUsing(creator => MapToDays(creator.BreedingPeriod, creator.BreedingPeriodUnit)))
                .ForMember(entity => entity.FemaleLifespan, expression => expression.ResolveUsing(creator => MapToDays(creator.FemaleLifespan, creator.FemaleLifespanUnit)))
                .ForMember(entity => entity.GestationPeriod, expression => expression.ResolveUsing(creator => MapToDays(creator.GestationPeriod, creator.GestationPeriodUnit)))
                .ForMember(entity => entity.MaleLifespan, expression => expression.ResolveUsing(creator => MapToDays(creator.MaleLifespan, creator.MaleLifespanUnit)))
                .ForMember(entity => entity.OldMaleAlertAdvance, expression => expression.ResolveUsing(creator => MapToDays(creator.OldMaleAlertAdvance, creator.OldMaleAlertAdvanceUnit)))
                .ForMember(entity => entity.WeaningPeriod, expression => expression.ResolveUsing(creator => MapToDays(creator.WeaningPeriod, creator.WeaningPeriodUnit)))
                .ForMember(entity => entity.WeaningAlertAdvance, expression => expression.ResolveUsing(creator => MapToDays(creator.WeaningAlertAdvance, creator.WeaningAlertAdvanceUnit)))
                .ForMember(entity => entity.OldFemaleAlertAdvance, expression => expression.ResolveUsing(creator => MapToDays(creator.OldFemaleAlertAdvance, creator.OldFemaleAlertAdvanceUnit)));

            CreateMap<SettingsEntity, SettingsModel>()
                .ForMember(model => model.BreedingAlertAdvance, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.BreedingAlertAdvance, (TimeUnits)entity.BreedingAlertAdvanceUnit)))
                .ForMember(model => model.BreedingPeriod, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.BreedingPeriod, (TimeUnits)entity.BreedingPeriodUnit)))
                .ForMember(model => model.FemaleLifespan, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.FemaleLifespan, (TimeUnits)entity.FemaleLifespanUnit)))
                .ForMember(model => model.GestationPeriod, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.GestationPeriod, (TimeUnits)entity.GestationPeriodUnit)))
                .ForMember(model => model.MaleLifespan, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.MaleLifespan, (TimeUnits)entity.MaleLifespanUnit)))
                .ForMember(model => model.OldMaleAlertAdvance, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.OldMaleAlertAdvance, (TimeUnits)entity.OldMaleAlertAdvanceUnit)))
                .ForMember(model => model.WeaningPeriod, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.WeaningPeriod, (TimeUnits)entity.WeaningPeriodUnit)))
                .ForMember(model => model.WeaningAlertAdvance, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.WeaningAlertAdvance, (TimeUnits)entity.WeaningAlertAdvanceUnit)))
                .ForMember(model => model.OldFemaleAlertAdvance, exp => exp.ResolveUsing(entity => MapToCorrectUnit(entity.OldFemaleAlertAdvance, (TimeUnits)entity.OldFemaleAlertAdvanceUnit)));
        }

        private int MapToDays(int span, TimeUnits unit)
        {
            switch(unit)
            {
                case TimeUnits.Days:
                    return span;
                case TimeUnits.Weeks:
                    return span * 7;
                case TimeUnits.Months:
                    return span * 30;
                case TimeUnits.Years:
                    return span * 365;
                default:
                    return span;
            }
        }

        private int MapToCorrectUnit(int timeInDays, TimeUnits unit)
        {
            switch (unit)
            {
                case TimeUnits.Days:
                    return timeInDays;
                case TimeUnits.Weeks:
                    return timeInDays / 7;
                case TimeUnits.Months:
                    return timeInDays / 30;
                case TimeUnits.Years:
                    return timeInDays / 365;
                default:
                    return 0;
            }
        }
    }
}