using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace MouseApi.Entities
{
    [Table("litter_log")]
    public class LitterLogEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("dob")]
        public DateTime DOB { get; set; }
        [Column("father_id")]
        public string FatherId { get; set; }
        [Column("mother_id")]
        public string MotherId { get; set; }
    }
}