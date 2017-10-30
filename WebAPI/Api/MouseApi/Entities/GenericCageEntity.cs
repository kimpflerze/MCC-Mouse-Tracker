using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace MouseApi.Entities
{
    [Table("generic_cage")]
    public class GenericCageEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }
        [Column("create_date")]
        public DateTime Created { get; set; }
        [Column("row_num")]
        public int Row { get; set; }
        [Column("column_num")]
        public int Column { get; set; }
        [Column("rack_num")]
        public int Rack { get; set; }
        [Column("active_flag")]
        public int Active { get; set; }

        public virtual ICollection<ParentCageLookupEntity> ParentCages { get; set; }
    }
}