using FluentValidation.Results;

namespace MouseApi.Validator
{
    /// <summary>
    /// Interface for interacting with base validator functionality.
    /// </summary>
    /// <typeparam name="TEntity">The entity to validate.</typeparam>
    public interface IBaseValidator<TEntity> where TEntity : class 
    {
        /// <summary>
        /// Validates the given <see cref="TEntity"/>.
        /// </summary>
        /// <param name="entity">The <see cref="TEntity"/>to validate</param>
        /// <returns>A <see cref="ValidationResult"/>containing the results of the validation.</returns>
        ValidationResult Validate(TEntity entity);
    }
}
