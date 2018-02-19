using MouseApi.Shared;

namespace MouseApi.ViewModels
{
    public class SettingsModel
    {
        public int Rows { get; set; }
        public int Columns { get; set; }
        public int Racks { get; set; }
        public int WeaningPeriod { get; set; }
        public int BreedingPeriod { get; set; }
        public int GestationPeriod { get; set; }
        public int MaleLifespan { get; set; }
        public int FemaleLifespan { get; set; }
        public double MaleCost { get; set; }
        public double FemaleCost { get; set; }
        public double CageCost { get; set; }
        public int BreedingAlertAdvance { get; set; }
        public int WeaningAlertAdvance { get; set; }
        public int OldMaleAlertAdvance { get; set; }
        public int OldFemaleAlertAdvance { get; set; }

        public TimeUnits WeaningPeriodUnit { get; set; }
        public TimeUnits BreedingPeriodUnit { get; set; }
        public TimeUnits GestationPeriodUnit { get; set; }
        public TimeUnits MaleLifespanUnit { get; set; }
        public TimeUnits FemaleLifespanUnit { get; set; }

        public TimeUnits BreedingAlertAdvanceUnit { get; set; }
        public TimeUnits WeaningAlertAdvanceUnit { get; set; }
        public TimeUnits OldMaleAlertAdvanceUnit { get; set; }
        public TimeUnits OldFemaleAlertAdvanceUnit { get; set; }

        public int MaleInCageColor { get; set; }
        public int PupsInCageColor { get; set; }
        public int PupsToWeanColor { get; set; }
        public int MaleTooOldColor { get; set; }
        public int FemaleTooOldColor { get; set; }
        public int CageWithOrderColor { get; set; }
    }
}