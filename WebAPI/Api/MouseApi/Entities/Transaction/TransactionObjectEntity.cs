using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities.Transaction
{
    [Table("transaction_object")]
    public class TransactionObjectEntity
    {
        [Key]
        [Column("object_id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        [Column("object_description")]
        public string ObjectDescription { get; set; }
    }
}