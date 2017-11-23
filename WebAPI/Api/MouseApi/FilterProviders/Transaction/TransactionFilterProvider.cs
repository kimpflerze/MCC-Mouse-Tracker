using MouseApi.Entities.Transaction;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MouseApi.FilterProviders.Transaction
{
    public class TransactionFilterProvider : BaseFilterProvider<TransactionEntity>, ITransactionFilterProvider
    {
        public override IEnumerable<TransactionEntity> Filter(IEnumerable<TransactionEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams)
        {
            foreach (var filter in queryParams)
            {
                switch (filter.Key)
                {
                    case "event":
                        list = list.Where(x => x.TransactionEventId == Int32.Parse(filter.Value));
                        break;
                    default:
                        break;
                }
            }
            return list;
        }
    }
}