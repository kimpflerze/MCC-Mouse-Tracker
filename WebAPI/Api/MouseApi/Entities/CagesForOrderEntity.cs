using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("cages_for_order")]
    public class CagesForOrderEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }

        [Column("selling_cage_id")]
        public string SellingCageId { get; set; }
        [Column("order_id")]
        public string OrderId { get; set; }
        [Column("num_mice")]
        public int NumberOfMice { get; set; }

        [ForeignKey("SellingCageId")]
        public virtual SellingCageEntity SellingCage { get; set; }
        [ForeignKey("OrderId")]
        public virtual OrderEntity Order { get; set; }
    }
}