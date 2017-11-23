using MouseApi.ViewModels;
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
        public override string Id { get; set; }
        [Column("alert_type")]
        public int AlertTypeId { get; set; }
        [Column("subject_id")]
        public string SubjectId { get; set; }
        [Column("alert_date")]
        public DateTime AlertDate { get; set; }
        [ForeignKey("AlertTypeId")]
        public virtual AlertTypeEntity AlertType { get; set; }
        [NotMapped]
        public  BreedingCageEntity BreedingCage { get; set; }
        [NotMapped]
        public BreedingMaleEntity BreedingMale { get; set; }
    }
}