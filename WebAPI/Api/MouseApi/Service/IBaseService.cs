using System.Collections.Generic;
using System.Threading.Tasks;

namespace MouseApi.Service
{
    public interface IBaseService<TEntity> where TEntity : class
    {
        IEnumerable<TEntity> Get(IEnumerable<KeyValuePair<string, string>> queryParams);
        Task<IEnumerable<TEntity>> GetAsync();
        TEntity Find(params object[] keyValues);
        Task<TEntity> FindAsync(params object[] keyValues);
        TEntity Add(TEntity entity);
        Task AddAsync(TEntity entity);
        TEntity Update(TEntity entity);
        Task UpdateAsync(TEntity entity, params object[] keyValues);
        void Delete(params object[] keyValues);
        Task DeleteAsync(params object[] keyValues);
    }
}
