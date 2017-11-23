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
    }
}