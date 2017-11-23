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
    }
}