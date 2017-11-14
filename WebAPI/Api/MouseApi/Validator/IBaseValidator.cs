using FluentValidation.Results;

namespace MouseApi.Validator
{
    public interface IBaseValidator<TEntity> where TEntity : class 
    {
        ValidationResult Validate(TEntity entity);
    }
}
