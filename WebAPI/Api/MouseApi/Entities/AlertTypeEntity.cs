using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("alert_type")]
    public class AlertTypeEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        [Column("description")]
        public string Description { get; set; }
    }
}