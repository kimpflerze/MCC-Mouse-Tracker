using FluentValidation;
using MouseApi.DataAccess;
using MouseApi.FilterProviders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MouseApi.Service
{
    public abstract class BaseService<TEntity, TValidator, TFilterProvider> 
        where TEntity : class 
        where TValidator : AbstractValidator<TEntity>
        where TFilterProvider : IBaseFilterProvider<TEntity>
    {     
        protected MouseTrackDbContext _dbContext;
        protected IBaseRepository<TEntity> _repository;
        protected TValidator _validator;
        protected TFilterProvider _provider;

        public BaseService(MouseTrackDbContext dbContext
            , IBaseRepository<TEntity> respository
            , TValidator validator
            , TFilterProvider provider)
        {
            _dbContext = dbContext;
            _repository = respository;
            _validator = validator;
            _provider = provider;

        }

        public virtual IEnumerable<TEntity> Get(IEnumerable<KeyValuePair<string,string>> queryParams)
        {
            if (queryParams.Count() > 0)
            {
                return _provider.Filter(_repository.Get(), queryParams);
            }
            return _repository.Get();
        }

        public virtual async Task<IEnumerable<TEntity>> GetAsync()
        {
            return await _repository.GetAsync();
        }

        public virtual TEntity Find(params object[] keyValues)
        {
            return _repository.Find(keyValues);
        }

        public virtual async Task<TEntity> FindAsync(params object[] keyValues)
        {
            return await _repository.FindAsync(keyValues);
        }

        public virtual TEntity Add(TEntity entity)
        {
            var result = _validator.Validate(entity);

            if (!result.IsValid)
            {
                throw new Exception(result.Errors.ToString());
            }
            return _repository.Add(entity);
        }

        public virtual async Task AddAsync(TEntity entity)
        {
            await _repository.AddAsync(entity);
        }

        public virtual TEntity Update(TEntity entity)
        {
            return _repository.Update(entity);
        }

        public virtual async Task UpdateAsync(TEntity entity, params object[] keyValues)
        {
            await _repository.UpdateAsync(entity, keyValues);
        }

        public virtual void Delete(params object[] keyValues)
        {
            _repository.Delete(keyValues);
        }

        public virtual async Task DeleteAsync(params object[] keyValues)
        {
            await _repository.DeleteAsync(keyValues);
        }
    }
}