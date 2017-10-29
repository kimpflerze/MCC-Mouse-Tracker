using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("Sample")]
    public class SampleEntity
    {
        [Key]
        [Column("Id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        [Column("sample_name")]
        public string Name { get; set; }
        [Column("sample_number")]
        public int Number { get; set; }
    }
}