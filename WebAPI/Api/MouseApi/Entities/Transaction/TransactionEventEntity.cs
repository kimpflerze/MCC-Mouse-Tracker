using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities.Transaction
{
    [Table("transaction_event")]
    public class TransactionEventEntity
    {
        [Key]
        [Column("event_id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        [Column("event_description")]
        public string EventDescription { get; set; }
    }
}