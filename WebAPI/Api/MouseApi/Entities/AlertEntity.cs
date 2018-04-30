using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("alerts")]
    public class AlertEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int AlertId { get; set; }
        [NotMapped]
        public override string Id { get; set; }
        [Column("alert_type")]
        public int AlertTypeId { get; set; }
        [Column("subject_id")]
        public string SubjectId { get; set; }
        [Column("alert_date")]
        public DateTime AlertDate { get; set; }
        [Column("resolved")]
        public int Resolved { get; set; }
        [ForeignKey("AlertTypeId")]
        public virtual AlertTypeEntity AlertType { get; set; }
        [ForeignKey("SubjectId")]
        public virtual  BreedingCageEntity BreedingCage { get; set; }
        [ForeignKey("SubjectId")]
        public virtual BreedingMaleEntity BreedingMale { get; set; }
    }
}