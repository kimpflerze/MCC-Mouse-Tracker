using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("breeding_male")]
    public class BreedingMaleEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("mother_cage_id")]
        public string MotherCageId { get; set; }
        [Column("dob")]
        public DateTime DOB { get; set; }
        [Column("current_cage_id")]
        public string CurrentCageId { get; set; }
        [Column("active")]
        public int Active { get; set; }

        [ForeignKey("MotherCageId")]
        public virtual BreedingCageEntity MotherCage { get; set; }
        [ForeignKey("CurrentCageId")]
        public virtual GenericCageEntity CurrentCage { get; set; }
        public virtual ICollection<AlertEntity> Alerts { get; set; }
    }
}