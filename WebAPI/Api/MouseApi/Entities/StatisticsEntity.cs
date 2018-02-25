using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MouseApi.Entities
{
    [Table("statistics")]
    public class StatisticsEntity : BaseEntity
    {
        [Key]
        [Column("id")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public override string Id { get; set; }

        [Column("breeding_males")]
        public int BreedingMales { get; set; }

        [Column("breeding_cages")]
        public int BreedingCages { get; set; }

        [Column("num_litters")]
        public int NumberOfLitters { get; set; }

        [Column("selling_cages")]
        public int SellingCages { get; set; }

        [Column("stock_mice")]
        public int StockMice { get; set; }

        [Column("stock_males")]
        public int StockMales { get; set; }

        [Column("stock_females")]
        public int StockFemales { get; set; }

        [Column("males_ordered")]
        public int MalesOrdered { get; set; }

        [Column("females_ordered")]
        public int FemalesOrdered { get; set; }

        [Column("alerts")]
        public int Alerts { get; set; }

        [Column("orders")]
        public int Orders { get; set; }
    }
}