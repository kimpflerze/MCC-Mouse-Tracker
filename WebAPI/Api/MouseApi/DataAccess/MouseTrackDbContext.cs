using MouseApi.Entities;
using MouseApi.Entities.Test;
using MouseApi.Entities.Transaction;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace MouseApi.DataAccess
{
    public class MouseTrackDbContext : DbContext
    {
        public MouseTrackDbContext()
            : base($"name={ConfigurationManager.AppSettings["DatabaseName"]}")
        {

        }
        public void Detach(object entity)
        {
            ((IObjectContextAdapter)this).ObjectContext.Detach(entity);
        }
        public DbSet<GenericCageEntity> GenericCages { get; set; }
        public DbSet<BreedingCageEntity> BreedingCages { get; set; }
        public DbSet<ParentCageLookupEntity> ParentCageLookups { get; set; }
        public DbSet<BreedingMaleEntity> BreedingMales { get; set; }
        public DbSet<LitterLogEntity> LitterLogs { get; set; }
        public DbSet<SellingCageEntity> SellingCages { get; set; }
        public DbSet<TransactionEntity> Transactions { get; set; }
        public DbSet<TransactionEventEntity> TransactionEvents { get; set; }
        public DbSet<AlertEntity> Alerts { get; set; }
        public DbSet<SettingsEntity> Settings { get; set; }
        public virtual DbSet<TestEntity> TestEntities { get; set; }
        public DbSet<OrderEntity> Orders { get; set; }
    }
}