namespace MouseApi.DataAccess
{
    public interface IUnitOfWork
    {
        BaseRepository<TEntity> Repository<TEntity>() where TEntity : class;
    }
}
