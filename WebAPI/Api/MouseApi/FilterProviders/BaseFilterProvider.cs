using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.FilterProviders
{
    public abstract class BaseFilterProvider<TEntity> : IBaseFilterProvider<TEntity> where TEntity : class
    {
        public abstract IEnumerable<TEntity> Filter(IEnumerable<TEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams);
    }
}