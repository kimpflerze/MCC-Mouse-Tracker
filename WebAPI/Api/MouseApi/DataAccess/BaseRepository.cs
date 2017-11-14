using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace MouseApi.DataAccess
{
    public class BaseRepository<TEntity> : IBaseRepository<TEntity> where TEntity: class
    {
        protected DbSet<TEntity> _dbSet;
        protected MouseTrackDbContext _dbContext;

        public BaseRepository(MouseTrackDbContext dbContext)
        {
            _dbContext = dbContext;
            _dbSet = _dbContext.Set<TEntity>();

        }

        public virtual IEnumerable<TEntity> Get()
        {
            return  _dbSet.ToList<TEntity>();
        }

        public virtual async Task<IEnumerable<TEntity>> GetAsync()
        {
            return await _dbSet.ToListAsync<TEntity>();
        }

        public virtual TEntity Find(params object[] keyvalues)
        {
            return _dbSet.Find(keyvalues);
        }

        public virtual async Task<TEntity> FindAsync(params object[] keyValues)
        {
            return await _dbSet.FindAsync(keyValues);
        }

        public virtual TEntity Add(TEntity entity)
        {
            _dbSet.Add(entity);
            _dbContext.SaveChanges();
            return entity;
        }

        public virtual async Task AddAsync(TEntity entity)
        {
            _dbSet.Add(entity);
            await _dbContext.SaveChangesAsync();
        }

        public virtual TEntity Update(TEntity entity)
        {
            _dbSet.Attach(entity);
            _dbContext.Entry(entity).State = EntityState.Modified;
            _dbContext.SaveChanges();

            return entity;
        }

        public virtual async Task UpdateAsync(TEntity entity, params object[] keyValues)
        {
            var oldEntity = await FindAsync(keyValues);
            if (oldEntity == null)
            {
                //Handle error
            }

            _dbContext.Entry(oldEntity).CurrentValues.SetValues(entity);
            await _dbContext.SaveChangesAsync();
        }

        public virtual void Delete(params object[] keyValues)
        {
            var entity = Find(keyValues);
            if(entity == null)
            {
                //Handle Error
            }

            if (_dbContext.Entry(entity).State == EntityState.Detached)
            {
                _dbSet.Attach(entity);
            }
            _dbSet.Remove(entity);
            _dbContext.SaveChanges();
        }

        public virtual async Task DeleteAsync(params object[] keyValues)
        {
            var entity = await FindAsync(keyValues);
            if (entity == null)
            {
                //Handle Error
            }

            if (_dbContext.Entry(entity).State == EntityState.Detached)
            {
                _dbSet.Attach(entity);
            }
            _dbSet.Remove(entity);
            await _dbContext.SaveChangesAsync();
        }
    }
}