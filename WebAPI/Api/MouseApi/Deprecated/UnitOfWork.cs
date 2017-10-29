namespace MouseApi.DataAccess
{
    public class UnitOfWork : IUnitOfWork
    {
        public MouseTrackDbContext _dbContext;

        public UnitOfWork(MouseTrackDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public BaseRepository<TEntity> Repository<TEntity>() where TEntity : class
        {
            return new BaseRepository<TEntity>(_dbContext);
        }
    }
}