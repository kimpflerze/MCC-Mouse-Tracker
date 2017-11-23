using FluentValidation;
using MouseApi.Entities.Transaction;

namespace MouseApi.Validator.Transaction
{
    public class TransactionValidator : AbstractValidator<TransactionEntity>, ITransactionValidator
    {
    }
}