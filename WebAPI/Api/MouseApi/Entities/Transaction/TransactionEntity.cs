using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities.Transaction
{
    [Table("transaction_log")]
    public class TransactionEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("transaction_event")]
        public int TransactionEventId { get; set; }
        [Column("transaction_object")]
        public int TransactionObjectId { get; set; }
        [Column("user_email")]
        public string UserEmail { get; set; }
        [Column("transaction_date")]
        public DateTime TransactionDate { get; set; }

        [ForeignKey("TransactionEventId")]
        public virtual TransactionEventEntity Event { get; set; }
        [ForeignKey("TransactionObjectId")]
        public virtual TransactionObjectEntity Object { get; set; }
    }

}