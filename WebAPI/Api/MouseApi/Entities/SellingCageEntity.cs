using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("selling_cage")]
    public class SellingCageEntity : BaseEntity
    {
        [Key]
        [Column("id"), ForeignKey("GenericCage")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("num_mice")]
        public int NumberOfMice { get; set; }
        [Column("gender_flag")]
        public int Gender { get; set; }

        public virtual GenericCageEntity GenericCage { get; set; }

        [ForeignKey("SellingCageId")]
        public virtual List<CagesForOrderEntity> CagesForOrder { get; set; }
    }
}