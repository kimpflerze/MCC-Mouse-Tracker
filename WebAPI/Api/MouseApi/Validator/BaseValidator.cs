using FluentValidation;

namespace MouseApi.Validator
{
    public abstract class BaseValidator<TEntity> : AbstractValidator<TEntity>
    {
    }
}