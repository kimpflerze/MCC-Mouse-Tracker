using MouseApi.Entities;
using System.Configuration;
using System.Data.Entity;

namespace MouseApi.DataAccess
{
    public class MouseTrackDbContext : DbContext
    {
        public MouseTrackDbContext()
            : base($"name={ConfigurationManager.AppSettings["DatabaseName"]}")
        {

        }
        public DbSet<GenericCageEntity> GenericCages { get; set; }
        public DbSet<BreedingCageEntity> BreedingCages { get; set; }
        public DbSet<ParentCageLookupEntity> ParentCageLookups { get; set; }
        public DbSet<BreedingMaleEntity> BreedingMales { get; set; }
        public DbSet<LitterLogEntity> LitterLogs { get; set; }
        public DbSet<SellingCageEntity> SellingCages { get; set; }
    }
}