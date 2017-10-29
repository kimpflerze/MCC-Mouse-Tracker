using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("parent_cage_lookup")]
    public class ParentCageLookupEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("current_cage_id"), ForeignKey("GenericCage")]
        public string CurrentCageId { get; set; }
        [Column("parent_cage_id")]
        public string ParentCageId { get; set; }
        [Column("dob")]
        public DateTime DOB { get; set; }

        [JsonIgnore]
        public virtual GenericCageEntity GenericCage { get; set; }
    }
}