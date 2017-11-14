using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("breeding_cage")]
    public class BreedingCageEntity : BaseEntity
    {
        [Key]
        [Column("id"), ForeignKey("GenericCage")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("litter_dob")]
        public DateTime? LitterDOB { get; set; }
        [Column("num_litters_from_cage")]
        public int LittersFromCage { get; set; }
        
        public virtual GenericCageEntity GenericCage { get; set; }
    }
}