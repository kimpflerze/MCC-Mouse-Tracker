using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("orders")]
    public class OrderEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public override string Id { get; set; }

        [Column("lab")]
        public string Lab { get; set; }

        [Column("protocol")]
        public int Protocol { get; set; }

        [Column("principal_investigator")]
        public string PrincipalInvestigator { get; set; }

        [Column("charged")]
        public int Charged { get; set; }

        [Column("delivery_date")]
        public DateTime DeliveryDate { get; set; }

        [Column("number_of_male_mice")]
        public int MaleMice { get; set; }

        [Column("number_of_female_mice")]
        public int FemaleMice { get; set; }

        [Column("gender")]
        public int Gender { get; set; }

        [Column("minimum_age")]
        public int MinimumAge { get; set; }

        [Column("maximum_age")]
        public int MaximumAge { get; set; }

        [Column("address")]
        public string Address { get; set; }

        [Column("room_number")]
        public string Room { get; set; }

        [Column("active")]
        public int Active { get; set; }
    }
}