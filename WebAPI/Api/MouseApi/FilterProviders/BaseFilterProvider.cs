using System.Collections.Generic;

namespace MouseApi.FilterProviders
{
    public abstract class BaseFilterProvider<TEntity> : IBaseFilterProvider<TEntity> where TEntity : class
    {
        public abstract IEnumerable<TEntity> Filter(IEnumerable<TEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams);
    }
}