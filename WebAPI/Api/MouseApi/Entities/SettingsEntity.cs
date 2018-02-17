using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("settings")]
    public class SettingsEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("num_rows")]
        public int Rows { get; set; }
        [Column("num_columns")]
        public int Columns { get; set; }
        [Column("num_racks")]
        public int Racks { get; set; }
        [Column("weaning_period")]
        public int WeaningPeriod { get; set; }
        [Column("breeding_period")]
        public int BreedingPeriod { get; set; }
        [Column("gestation_period")]
        public int GestationPeriod { get; set; }
        [Column("male_lifespan")]
        public int MaleLifespan { get; set; }
        [Column("female_lifespan")]
        public int FemaleLifespan { get; set; }
        [Column("male_cost")]
        public decimal MaleCost { get; set; }
        [Column("female_cost")]
        public decimal FemaleCost { get; set; }
        [Column("cage_cost")]
        public decimal CageCost { get; set; }
        [Column("breeding_alert_advance")]
        public int BreedingAlertAdvance { get; set; }
        [Column("weaning_alert_advance")]
        public int WeaningAlertAdvance { get; set; }
        [Column("old_male_alert_advance")]
        public int OldMaleAlertAdvance { get; set; }
        [Column("old_female_alert_advance")]
        public int OldFemaleAlertAdvance { get; set; }

        [Column("weaning_period_unit")]
        public int WeaningPeriodUnit { get; set; }
        [Column("breeding_period_unit")]
        public int BreedingPeriodUnit { get; set; }
        [Column("gestation_period_unit")]
        public int GestationPeriodUnit { get; set; }
        [Column("male_lifespan_unit")]
        public int MaleLifespanUnit { get; set; }
        [Column("female_lifespan_unit")]
        public int FemaleLifespanUnit { get; set; }

        [Column("breeding_alert_advance_unit")]
        public int BreedingAlertAdvanceUnit { get; set; }
        [Column("weaning_alert_advance_unit")]
        public int WeaningAlertAdvanceUnit { get; set; }
        [Column("old_male_alert_advance_unit")]
        public int OldMaleAlertAdvanceUnit { get; set; }
        [Column("old_female_alert_advance_unit")]
        public int OldFemaleAlertAdvanceUnit { get; set; }

        [Column("male_in_cage_color")]
        public int MaleInCageColor { get; set; }
        [Column("pups_in_cage_color")]
        public int PupsInCageColor { get; set; }
        [Column("pups_to_wean_color")]
        public int PupsToWeanColor { get; set; }
        [Column("male_too_old_color")]
        public int MaleTooOldColor { get; set; }
        [Column("female_too_old_color")]
        public int FemaleTooOldColor { get; set; }
        [Column("cage_with_order_color")]
        public int CageWithOrderColor { get; set; }
    }
}