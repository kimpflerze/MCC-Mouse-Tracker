using MouseApi.DataAccess;
using MouseApi.Entities.Transaction;
using MouseApi.FilterProviders.Transaction;
using MouseApi.Patchers.Transaction;
using MouseApi.Validator.Transaction;

namespace MouseApi.Service.Transaction
{
    public class TransactionService : BaseService<TransactionEntity, TransactionValidator, ITransactionFilterProvider, ITransactionPatcher>, ITransactionService
    {
        public TransactionService(MouseTrackDbContext dbContext
            , IBaseRepository<TransactionEntity> respository
            , TransactionValidator validator
            , TransactionFilterProvider provider
            , ITransactionPatcher patcher) : base(dbContext, respository, validator, provider, patcher)
        {
        }
    }
}