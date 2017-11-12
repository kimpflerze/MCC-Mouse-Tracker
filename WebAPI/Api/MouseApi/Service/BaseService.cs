using FluentValidation;
using MouseApi.DataAccess;
using MouseApi.FilterProviders;
using MouseApi.Patchers;
using MouseApi.Validator;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MouseApi.Service
{
    public abstract class BaseService<TEntity, TValidator, TFilterProvider, TPatcher>
        where TEntity : class 
        where TValidator : BaseValidator<TEntity>
        where TFilterProvider : IBaseFilterProvider<TEntity>
        where TPatcher : IBasePatcher<TEntity>
    {     
        protected MouseTrackDbContext _dbContext;
        protected IBaseRepository<TEntity> _repository;
        protected TValidator _validator;
        protected TFilterProvider _provider;
        protected TPatcher _patcher;

        public BaseService(MouseTrackDbContext dbContext
            , IBaseRepository<TEntity> respository
            , TValidator validator
            , TFilterProvider provider
            , TPatcher patcher)
        {
            _dbContext = dbContext;
            _repository = respository;
            _validator = validator;
            _provider = provider;
            _patcher = patcher;

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
            var validationResult = _validator.Validate(entity);

            if (!validationResult.IsValid)
            {
                throw new ValidationException(validationResult.Errors.First().ErrorMessage);
            }
            return _repository.Add(entity);
        }

        public virtual async Task AddAsync(TEntity entity)
        {
            await _repository.AddAsync(entity);
        }

        public virtual TEntity Update(TEntity entity)
        {
            var validationResult = _validator.Validate(entity);

            if (!validationResult.IsValid)
            {
                throw new ValidationException(validationResult.Errors.First().ErrorMessage);
            }
            return _repository.Update(entity);
        }

        public virtual async Task UpdateAsync(TEntity entity, params object[] keyValues)
        {
            await _repository.UpdateAsync(entity, keyValues);
        }

        public virtual TEntity Delete(params object[] keyValues)
        {
            return _repository.Delete(keyValues);
        }

        public virtual async Task DeleteAsync(params object[] keyValues)
        {
            await _repository.DeleteAsync(keyValues);
        }

        public virtual TEntity Patch(string id, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            var oldEntity = Find(id);
            return Update(_patcher.Patch(oldEntity, patchedProperties));
        }
    }
}