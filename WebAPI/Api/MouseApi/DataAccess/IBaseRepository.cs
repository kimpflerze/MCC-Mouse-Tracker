using System.Collections.Generic;
using System.Threading.Tasks;

namespace MouseApi.DataAccess
{
    /// <summary>
    /// Interface for the abstract base repository.
    /// Makes direct calls to the Database.
    /// </summary>
    /// <typeparam name="TEntity">The Entity type.</typeparam>
    public interface IBaseRepository<TEntity> where TEntity : class
    {
        IEnumerable<TEntity> Get();
        Task<IEnumerable<TEntity>> GetAsync();
        TEntity Find(params object[] keyvalues);
        Task<TEntity> FindAsync(params object[] keyValues);
        TEntity Add(TEntity entity);
        Task AddAsync(TEntity entity);
        TEntity Update(TEntity entity);
        Task UpdateAsync(TEntity entity, params object[] keyValues);
        void Delete(params object[] keyValues);
        Task DeleteAsync(params object[] keyValues);
    }
}
