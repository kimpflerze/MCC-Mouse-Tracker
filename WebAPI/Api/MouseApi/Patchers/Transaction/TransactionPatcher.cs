using MouseApi.Entities.Transaction;
using System;
using System.Collections.Generic;

namespace MouseApi.Patchers.Transaction
{
    public class TransactionPatcher : BasePatcher<TransactionEntity>, ITransactionPatcher
    {
        public override TransactionEntity Patch(TransactionEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties)
        {
            throw new NotImplementedException();
        }
    }
}